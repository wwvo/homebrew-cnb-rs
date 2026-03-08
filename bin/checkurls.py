#!/usr/bin/env python3
"""检查 Homebrew Formula 中的下载 URL 是否可访问。

用法：python bin/checkurls.py [formula_name]
  不指定 formula_name 则检查 Formula/ 下所有 .rb 文件。
"""

import re
import sys
import urllib.request
from pathlib import Path

FORMULA_DIR = Path(__file__).resolve().parent.parent / "Formula"

# 匹配 Formula 中的 url 行
URL_PATTERN = re.compile(r'^\s*url\s+"(.+)"', re.MULTILINE)


def extract_urls(content: str) -> list[str]:
    """从 Formula 文件内容中提取所有 url。"""
    return URL_PATTERN.findall(content)


def check_url(url: str) -> tuple[bool, str]:
    """发送 HEAD 请求检查 URL 是否可访问。"""
    try:
        req = urllib.request.Request(url, method="HEAD")
        req.add_header("User-Agent", "Homebrew/1.0 (checkurls.py)")
        with urllib.request.urlopen(req, timeout=15) as resp:
            return True, str(resp.status)
    except urllib.error.HTTPError as e:
        return False, str(e.code)
    except Exception as e:
        return False, str(e)


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
        urls = extract_urls(content)

        if not urls:
            continue

        print(f"\n检查 {formula_path.name}：")
        for url in urls:
            ok, status = check_url(url)
            icon = "✅" if ok else "❌"
            print(f"  {icon} [{status}] {url}")
            if not ok:
                has_error = True

    return 1 if has_error else 0


if __name__ == "__main__":
    sys.exit(main())
