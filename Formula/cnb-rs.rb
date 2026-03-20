class CnbRs < Formula
  desc "An unofficial command line tool for CNB (cnb.cool)"
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
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.11.2/cnb-rs-v0.11.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "ed9ff6c2c33e6653ca6582423de6a23c7f1bf7e55df5c2f9667464d4b932c70b"
    end
    on_intel do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.11.2/cnb-rs-v0.11.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2e2d41ddf367c85c44d36afa44f1a9e7a4371adf5e8f5e0bf51c197fcef72f96"
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
