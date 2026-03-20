class CnbRsMusl < Formula
  desc "An unofficial command line tool for CNB (cnb.cool) (musl, statically linked)"
  homepage "https://cnb.wwvo.fun"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.11.3/cnb-rs-v0.11.3-aarch64-apple-darwin.tar.gz"
      sha256 "3e97a43d33164191592a1bf640582084e50f68a8fe373bcaa9eda8ff30091972"
    end
    on_intel do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.11.3/cnb-rs-v0.11.3-x86_64-apple-darwin.tar.gz"
      sha256 "22b8daa4cc70301ebd97ba44fbef8a6ca281d240157bfb6208ffbaf7d079ebd8"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.11.3/cnb-rs-v0.11.3-aarch64-unknown-linux-musl.tar.gz"
      sha256 "2290f07510742a93e16ee9c4a2dc14157fb1a34978aec5a3cac904585e365992"
    end
    on_intel do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.11.3/cnb-rs-v0.11.3-x86_64-unknown-linux-musl.tar.gz"
      sha256 "9a9493a30f6d4dafefca0aa4ff3898db83f4dce62a3187b0b20724c5bdaa2e41"
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
