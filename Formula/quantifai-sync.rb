# Generated from packaging/homebrew/quantifai-sync.rb in nino-chavez/quantifai-sync
# by `make formula`. Edit the template there; the tap copy is replaced on release.
class QuantifaiSync < Formula
  desc "Telemetry sync agent for Quantifai — streams AI tool usage to your dashboard"
  homepage "https://quantifai.app"
  version "0.4.6"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.6/quantifai-sync-darwin-arm64.tar.gz"
      sha256 "73bfb2b7f8e6c414b86b84c0f030998005a541054806b4e047147d1cb4f5ad3e"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.6/quantifai-sync-darwin-amd64.tar.gz"
      sha256 "a9b414aebd62dd195627de0d032ce9b24063c1fda294c6d94dca02052c8007a5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.6/quantifai-sync-linux-arm64.tar.gz"
      sha256 "ef57f9e01a6fa478f7b44071ac7ab00c8eed0db0d4a8b17c648d6ff962036c3e"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.6/quantifai-sync-linux-amd64.tar.gz"
      sha256 "3b221dfac31bcc58ceafe77368d1bea31e8de8e3a81569bcd426195d4babb9da"
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
