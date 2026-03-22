class CnbRsMusl < Formula
  desc "An unofficial command line tool for CNB (cnb.cool) (musl, statically linked)"
  homepage "https://cnb.wwvo.fun"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.12.1/cnb-rs-v0.12.1-aarch64-apple-darwin.tar.gz"
      sha256 "cb7aac32343aafc75588a4fd50c723e0411cd19aad8e48e036ff2f1623b61415"
    end
    on_intel do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.12.1/cnb-rs-v0.12.1-x86_64-apple-darwin.tar.gz"
      sha256 "edd0f70b0d27528fc08cd14b157c0a74586ce08bbcd57bca1368d1a501af2050"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.12.1/cnb-rs-v0.12.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a554c155d493f76aaf07c973b96de45fee11127b92a2dc9114ac24843dafd385"
    end
    on_intel do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.12.1/cnb-rs-v0.12.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "153f6d59313412a17e422441688e10bb4fb178efcf0670b0b11bf28d32d8160f"
    end
  end

  def install
    bin.install "cnb-rs"
    generate_completions_from_executable(bin/"cnb-rs", "completion", "-s")
  end

  def caveats
    <<~EOS
      The command has been renamed from `cnb` to `cnb-rs`.

      If you still want to use `cnb`, add an alias in your shell config:

      Bash / Zsh:
        alias cnb='cnb-rs'

      Fish:
        alias cnb cnb-rs
    EOS
  end

  test do
    assert_match "cnb-rs #{version}", shell_output("#{bin}/cnb-rs --version")
  end
end
