# Generated from packaging/homebrew/quantifai-sync.rb in nino-chavez/quantifai-sync
# by `make formula`. Edit the template there; the tap copy is replaced on release.
class QuantifaiSync < Formula
  desc "Telemetry sync agent for Quantifai — streams AI tool usage to your dashboard"
  homepage "https://quantifai.app"
  version "0.4.10"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.10/quantifai-sync-darwin-arm64.tar.gz"
      sha256 "74e461c21f29855b9c452813c6c42d0a3d52e0e1f15ddf1ce472e38e3b0cd26d"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.10/quantifai-sync-darwin-amd64.tar.gz"
      sha256 "bcb37cb25af8f506004af45d4171c6bf6b8e7205a0dd075360ff000de9406e8c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.10/quantifai-sync-linux-arm64.tar.gz"
      sha256 "dcbe6820d841083bf5ecb7863c447d7717738be79f2ed58b11bd9aa4ed0a0a9e"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.10/quantifai-sync-linux-amd64.tar.gz"
      sha256 "c6064c4200aa9a56ea34b00896acd2420a01d50b4d7e0c2463967a8f48dc5a0a"
    end
  end

  def install
    # Each release archive holds one binary named for its platform,
    # e.g. quantifai-sync-darwin-arm64.
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

  def caveats
    <<~EOS
      Store your API key and register the background service:
        quantifai-sync install --api-key YOUR_KEY
    EOS
  end

  test do
    assert_match "quantifai-sync", shell_output("#{bin}/quantifai-sync version")
  end
end
