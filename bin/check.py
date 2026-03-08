#!/usr/bin/env python3
"""验证 Homebrew Formula 中的下载 URL 和文件 hash。

用法：python bin/check.py [formula_name] [--url-only] [--hash-only]
  不指定 formula_name 则检查 Formula/ 下所有 .rb 文件。
  --url-only   仅检查 URL 可访问性（HEAD 请求）
  --hash-only  仅验证 hash（下载文件并计算 SHA256）
  默认同时检查 URL 和 hash。
"""

import hashlib
import re
import sys
import urllib.request
from pathlib import Path

FORMULA_DIR = Path(__file__).resolve().parent.parent / "Formula"

URL_PATTERN = re.compile(r'^\s*url\s+"(.+)"', re.MULTILINE)
SHA256_PATTERN = re.compile(r'^\s*sha256\s+"([0-9a-f]{64})"', re.MULTILINE)


def extract_url_hash_pairs(content: str) -> list[tuple[str, str]]:
    """从 Formula 文件内容中提取所有 (url, sha256) 对。"""
    urls = URL_PATTERN.findall(content)
    hashes = SHA256_PATTERN.findall(content)
    return list(zip(urls, hashes))


def check_url(url: str) -> tuple[bool, str]:
    """发送 HEAD 请求检查 URL 是否可访问。"""
    try:
        req = urllib.request.Request(url, method="HEAD")
        req.add_header("User-Agent", "Homebrew/1.0 (check.py)")
        with urllib.request.urlopen(req, timeout=15) as resp:
            return True, str(resp.status)
    except urllib.error.HTTPError as e:
        return False, str(e.code)
    except Exception as e:
        return False, str(e)


def check_hash(url: str, expected_hash: str) -> tuple[bool, str]:
    """下载文件并计算 SHA256，返回 (是否匹配，实际 hash)。"""
    try:
        req = urllib.request.Request(url, method="GET")
        req.add_header("User-Agent", "Homebrew/1.0 (check.py)")
        with urllib.request.urlopen(req, timeout=60) as resp:
            sha256 = hashlib.sha256()
            while True:
                chunk = resp.read(8192)
                if not chunk:
                    break
                sha256.update(chunk)
            actual = sha256.hexdigest()
            return actual == expected_hash, actual
    except Exception as e:
        return False, f"下载失败：{e}"


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("-")]
    flags = {a for a in sys.argv[1:] if a.startswith("-")}

    filter_name = args[0] if args else None
    url_only = "--url-only" in flags
    hash_only = "--hash-only" in flags
    check_both = not url_only and not hash_only

    formulas = sorted(FORMULA_DIR.glob("*.rb"))
    if filter_name:
        formulas = [f for f in formulas if f.stem == filter_name]

    if not formulas:
        print("未找到 Formula 文件。")
        return 1

    has_error = False
    for formula_path in formulas:
        content = formula_path.read_text(encoding="utf-8")
        pairs = extract_url_hash_pairs(content)

        if not pairs:
            continue

        print(f"\n{'=' * 60}")
        print(f"📦 {formula_path.name}")
        print(f"{'=' * 60}")

        for url, expected in pairs:
            # 从 URL 提取目标名称
            filename = url.rsplit("/", 1)[-1]
            print(f"\n  📄 {filename}")
            print(f"  URL:{url}")

            # 检查 URL
            if url_only or check_both:
                ok, status = check_url(url)
                icon = "✅" if ok else "❌"
                print(f"  URL 检查：{icon} [{status}]")
                if not ok:
                    has_error = True

            # 检查 hash
            if hash_only or check_both:
                print(f"  期望 hash：{expected}")
                ok, actual = check_hash(url, expected)
                if ok:
                    print(f"  Hash 检查：✅ 匹配")
                else:
                    print(f"  实际 hash：{actual}")
                    print(f"  Hash 检查：❌ 不匹配")
                    has_error = True

    print()
    if has_error:
        print("⚠️  存在错误，请检查上述输出。")
    else:
        print("✅ 全部通过！")

    return 1 if has_error else 0


if __name__ == "__main__":
    sys.exit(main())
