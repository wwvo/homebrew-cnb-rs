class CnbMusl < Formula
  desc "An unofficial command line tool for CNB (cnb.cool) (musl, statically linked)"
  homepage "https://cnb.wwvo.fun"
  license "Apache-2.0"
  version "0.4.1"

  on_macos do
    on_arm do
      url "https://cnb.cool/wwvo/cnb-cli/cnb/-/releases/download/v0.4.1/cnb-v0.4.1-aarch64-apple-darwin.tar.gz"
      sha256 "a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2"
    end
    on_intel do
      url "https://cnb.cool/wwvo/cnb-cli/cnb/-/releases/download/v0.4.1/cnb-v0.4.1-x86_64-apple-darwin.tar.gz"
      sha256 "b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3"
    end
  end

  on_linux do
    on_arm do
      url "https://cnb.cool/wwvo/cnb-cli/cnb/-/releases/download/v0.4.1/cnb-v0.4.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6"
    end
    on_intel do
      url "https://cnb.cool/wwvo/cnb-cli/cnb/-/releases/download/v0.4.1/cnb-v0.4.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1b2c3d4e5f6a1"
    end
  end

  def install
    bin.install "cnb"
    bin.install "git-cnb"

    # Shell 补全
    generate_completions_from_executable(bin/"cnb", "completion")
  end

  test do
    assert_match "cnb #{version}", shell_output("#{bin}/cnb --version")
  end
end
