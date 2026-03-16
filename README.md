# homebrew-cnb-rs

[![CNB](/-/badge/git/latest/ci/pipeline-as-code)](https://cnb.cool/wwvo/cnb-rs/homebrew-cnb-rs/-/pipelines)
[![Audit Homebrew Formulae](https://github.com/wwvo/homebrew-cnb-rs/actions/workflows/audit-formulae.yml/badge.svg?branch=main)](https://github.com/wwvo/homebrew-cnb-rs/actions/workflows/audit-formulae.yml)
[![Install And Test Homebrew Formulae](https://github.com/wwvo/homebrew-cnb-rs/actions/workflows/install-test-formulae.yml/badge.svg?branch=main)](https://github.com/wwvo/homebrew-cnb-rs/actions/workflows/install-test-formulae.yml)

[cnb-rs](https://cnb.cool/wwvo/cnb-rs/cnb-rs) 的 [Homebrew](https://brew.sh) Tap。

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

## 终端补全

Homebrew 安装时已自动生成并启用终端补全功能，无需额外配置。

支持 bash、zsh、fish、elvish 和 powershell 等常见 shell。

安装完成后，请重启终端或执行相应的 shell 重载命令使补全生效：

**Bash:**
```bash
source ~/.bashrc
```

**Zsh:**
```bash
source ~/.zshrc
```

**Fish:**
```bash
source ~/.config/fish/config.fish
```

## 相关链接

- [CNB CLI 文档](https://cnb.wwvo.fun)
- [CNB CLI 源码](https://cnb.cool/wwvo/cnb-rs/cnb-rs)
- [Homebrew 文档](https://docs.brew.sh)
