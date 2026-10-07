class QuantifaiSync < Formula
  desc "Telemetry sync agent for Quantifai — streams AI tool usage data to your dashboard"
  homepage "https://quantifai.app"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.3.0/quantifai-sync-darwin-arm64.tar.gz"
      sha256 "6e56b6f45000368dbac6101e7ac3b3de6fe256cea00a3045aa11ba4a938a27fd"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.3.0/quantifai-sync-darwin-amd64.tar.gz"
      sha256 "25ab4c095c6596e32e7b5d6df3ddc35d94b7ec2778e76f4566360861c1ed40ff"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.3.0/quantifai-sync-linux-arm64.tar.gz"
      sha256 "9e86eb725bf51b686d7c6c424317f2ef421d599149674f096b01253fdc5a929d"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.3.0/quantifai-sync-linux-amd64.tar.gz"
      sha256 "ba2e8960c9faf9a60463fc24d1516c03ca575a21479d9e93a8d3812857fdcc5b"
    end
  end

  def install
    # Binary is named with platform suffix in the tarball
    Dir.glob("quantifai-sync-*").each do |f|
      next if f.end_with?(".sha256")
      bin.install f => "quantifai-sync"
    end
  end

  service do
    run [opt_bin/"quantifai-sync", "run"]
    keep_alive true
    log_path var/"log/quantifai-sync.log"
    error_log_path var/"log/quantifai-sync.log"
  end

  def post_install
    ohai "Run 'quantifai-sync install --api-key YOUR_KEY --api-url YOUR_URL' to configure"
  end

  test do
    assert_match "quantifai-sync", shell_output("#{bin}/quantifai-sync version")
  end
end
