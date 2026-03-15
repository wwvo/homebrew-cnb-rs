class CnbRs < Formula
  desc "An unofficial command line tool for CNB (cnb.cool)"
  homepage "https://cnb.wwvo.fun"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.5.0/cnb-rs-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "7001fbaa10d7f2cbe24cd39c85d235c53fdf201cf88f6097e1a6243ba7039142"
    end
    on_intel do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.5.0/cnb-rs-v0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "23e39b872b1ef414c7e0f7db9f9d162b6dcc9ac4cb3e54e2af8162e9849a9334"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.5.0/cnb-rs-v0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7d30ae8e76d55caf0d52e9574c6b0805909a9f9f52a4c9fc9c4d35c1d408879a"
    end
    on_intel do
      url "https://github.com/wwvo/cnb-rs/releases/download/v0.5.0/cnb-rs-v0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "03955c480e143808e5fdb905201704c3b5ddb6bf51269200e4282e3feef19e5a"
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
