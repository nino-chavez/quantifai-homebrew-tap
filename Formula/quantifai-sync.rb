# Generated from packaging/homebrew/quantifai-sync.rb in nino-chavez/quantifai-sync
# by `make formula`. Edit the template there; the tap copy is replaced on release.
class QuantifaiSync < Formula
  desc "Telemetry sync agent for Quantifai — streams AI tool usage to your dashboard"
  homepage "https://quantifai.app"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.0/quantifai-sync-darwin-arm64.tar.gz"
      sha256 "1c20ab454305650e3a5ba5946acef6d3e359f6a550c340ad8e0e94724b143445"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.0/quantifai-sync-darwin-amd64.tar.gz"
      sha256 "22d2f67ea018e029da9004bc5393ffd026b07c3d126c140ae10bf9ece5fe9c1f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.0/quantifai-sync-linux-arm64.tar.gz"
      sha256 "9df640844b061771b9fcd69d4781834ef51b4099e8591bb15e8345744f607bab"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.0/quantifai-sync-linux-amd64.tar.gz"
      sha256 "c05b2d57e1658243319d59c7ead9ddabf3ea3978ff744c816ffec2f6fd7b916b"
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
