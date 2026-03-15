class CnbRsMusl < Formula
  desc "An unofficial command line tool for CNB (cnb.cool) (musl, statically linked)"
  homepage "https://cnb.wwvo.fun"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/wwvo/cnb-cli-rs/releases/download/v0.5.0/cnb-rs-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "7001fbaa10d7f2cbe24cd39c85d235c53fdf201cf88f6097e1a6243ba7039142"
    end
    on_intel do
      url "https://github.com/wwvo/cnb-cli-rs/releases/download/v0.5.0/cnb-rs-v0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "23e39b872b1ef414c7e0f7db9f9d162b6dcc9ac4cb3e54e2af8162e9849a9334"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/wwvo/cnb-cli-rs/releases/download/v0.5.0/cnb-rs-v0.5.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "ea5b416a416171bc5298da0462951a66b1b1c89a84a22bac46c4212710c75c26"
    end
    on_intel do
      url "https://github.com/wwvo/cnb-cli-rs/releases/download/v0.5.0/cnb-rs-v0.5.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "41af64b3a0983c9a98633e023b866220911a0a781f21bbca62983db7e0a06c03"
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

        alias cnb='cnb-rs'
    EOS
  end

  test do
    assert_match "cnb-rs #{version}", shell_output("#{bin}/cnb-rs --version")
  end
end
