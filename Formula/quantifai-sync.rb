# Generated from packaging/homebrew/quantifai-sync.rb in nino-chavez/quantifai-sync
# by `make formula`. Edit the template there; the tap copy is replaced on release.
class QuantifaiSync < Formula
  desc "Telemetry sync agent for Quantifai — streams AI tool usage to your dashboard"
  homepage "https://quantifai.app"
  version "0.4.4"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.4/quantifai-sync-darwin-arm64.tar.gz"
      sha256 "b69fc723d559a22a87906b44452a80da4f9173440a55f646a626c294f047adbb"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.4/quantifai-sync-darwin-amd64.tar.gz"
      sha256 "671b4cef24eec3e90db6a9943ad9ec0db9dc03ca00a9662647f160a80674979f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.4/quantifai-sync-linux-arm64.tar.gz"
      sha256 "522dcd2a21103401d54c159ddced67859db4c85ae583cc229afbfeeb9182acbd"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.4/quantifai-sync-linux-amd64.tar.gz"
      sha256 "04f88eee245822d1552925facd445e17255c882a7c00fcc9a26cb3b62d99ee32"
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
