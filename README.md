# homebrew-cnb-rs

[![Audit Homebrew Formulae](https://github.com/wwvo/homebrew-cnb-rs/actions/workflows/audit-formulae.yml/badge.svg?branch=main)](https://github.com/wwvo/homebrew-cnb-rs/actions/workflows/audit-formulae.yml)
[![Install And Test Homebrew Formulae](https://github.com/wwvo/homebrew-cnb-rs/actions/workflows/install-test-formulae.yml/badge.svg?branch=main)](https://github.com/wwvo/homebrew-cnb-rs/actions/workflows/install-test-formulae.yml)

[cnb-rs](https://cnb.cool/wwvo/cnb-rs/cnb) 的 [Homebrew](https://brew.sh) Tap。

`cnb-rs` 是一个非官方的 [CNB (cnb.cool)](https://cnb.cool) 命令行工具。

## 安装

```bash
brew tap wwvo/cnb-rs https://cnb.cool/wwvo/cnb-rs/homebrew-cnb-rs.git
brew install wwvo/cnb-rs/cnb-rs
```

## 更新

```bash
brew upgrade cnb-rs
```

## 迁移提示

主仓库的命令入口已从 `cnb` 改为 `cnb-rs`。

如果你仍希望继续输入 `cnb`，可以在 shell 配置中添加 alias：

```bash
alias cnb='cnb-rs'
```

## 相关链接

- [CNB CLI 文档](https://cnb.wwvo.fun)
- [CNB CLI 源码](https://cnb.cool/wwvo/cnb-rs/cnb)
- [Homebrew 文档](https://docs.brew.sh)
