#!/usr/bin/env python3
"""验证 Homebrew Formula 中的文件 hash 是否正确。

用法：python bin/checkhashes.py [formula_name]
  不指定 formula_name 则检查 Formula/ 下所有 .rb 文件。
"""

import hashlib
import re
import sys
import urllib.request
from pathlib import Path

FORMULA_DIR = Path(__file__).resolve().parent.parent / "Formula"

# 匹配 Formula 中的 url 和 sha256 行
URL_PATTERN = re.compile(r'^\s*url\s+"(.+)"', re.MULTILINE)
SHA256_PATTERN = re.compile(r'^\s*sha256\s+"([0-9a-f]{64})"', re.MULTILINE)


def extract_url_hash_pairs(content: str) -> list[tuple[str, str]]:
    """从 Formula 文件内容中提取所有 (url, sha256) 对。"""
    urls = URL_PATTERN.findall(content)
    hashes = SHA256_PATTERN.findall(content)
    return list(zip(urls, hashes))


def check_hash(url: str, expected_hash: str) -> tuple[bool, str]:
    """下载文件并计算 SHA256，返回 (是否匹配，实际 hash)。"""
    try:
        req = urllib.request.Request(url, method="GET")
        req.add_header("User-Agent", "Homebrew/1.0 (checkhashes.py)")
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
    filter_name = sys.argv[1] if len(sys.argv) > 1 else None
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

        print(f"\n检查 {formula_path.name}：")
        for url, expected in pairs:
            print(f"  URL:{url}")
            print(f"  期望：{expected}")
            ok, actual = check_hash(url, expected)
            if ok:
                print(f"  结果：✅ 匹配")
            else:
                print(f"  实际：{actual}")
                print(f"  结果：❌ 不匹配")
                has_error = True

    return 1 if has_error else 0


if __name__ == "__main__":
    sys.exit(main())
