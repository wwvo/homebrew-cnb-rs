class CnbRsMusl < Formula
  desc "An unofficial command line tool for CNB (cnb.cool) (musl, statically linked)"
  homepage "https://cnb.wwvo.fun"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.11.2/cnb-rs-v0.11.2-aarch64-apple-darwin.tar.gz"
      sha256 "c30b4596484afc566aa2f1501dd185b6f403ed39f74113c30367b82eca523ddd"
    end
    on_intel do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.11.2/cnb-rs-v0.11.2-x86_64-apple-darwin.tar.gz"
      sha256 "02dfabaee7bd5df479a180cf8e1b4b189a4bcf839aa02108c0fdbf9f430c2e44"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.11.2/cnb-rs-v0.11.2-aarch64-unknown-linux-musl.tar.gz"
      sha256 "b3f598bf7c07be1dca4cc01a216dd7837d101eef91a9b52cddb50c1bc99274f9"
    end
    on_intel do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.11.2/cnb-rs-v0.11.2-x86_64-unknown-linux-musl.tar.gz"
      sha256 "b5b9385f3400d5d540aa85f030b41623f35a9fd178bcd9cce5707d8cd721fd31"
    end
  end

  def install
    bin.install "cnb-rs"
    generate_completions_from_executable(bin/"cnb-rs", "completion")
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
