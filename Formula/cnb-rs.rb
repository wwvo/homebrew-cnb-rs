class CnbRs < Formula
  desc "An unofficial command line tool for CNB (cnb.cool)"
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
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.12.1/cnb-rs-v0.12.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "3ba23b45b972ff93ecbf1345f16f597d46afc4e1ca943b8bf6814265a2c13d3b"
    end
    on_intel do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.12.1/cnb-rs-v0.12.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "32facf51898684f29841f41c10ba03884adf9d15658c7e1ea436982098680e90"
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
