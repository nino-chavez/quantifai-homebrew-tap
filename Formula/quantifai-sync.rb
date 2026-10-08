# Generated from packaging/homebrew/quantifai-sync.rb in nino-chavez/quantifai-sync
# by `make formula`. Edit the template there; the tap copy is replaced on release.
class QuantifaiSync < Formula
  desc "Telemetry sync agent for Quantifai — streams AI tool usage to your dashboard"
  homepage "https://quantifai.app"
  version "0.4.9"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.9/quantifai-sync-darwin-arm64.tar.gz"
      sha256 "b5c6dc4baefaa3a2b702f91d676e72cc7b1ea9cbf39cd4bf644ce280266639e0"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.9/quantifai-sync-darwin-amd64.tar.gz"
      sha256 "bdb8cb2b2ffc63e58803bae066f7eb26d7aa3ce3054dba4c793abd548c38efb1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.9/quantifai-sync-linux-arm64.tar.gz"
      sha256 "29196f22feca353029def00ea255c6892ce2cfd18f22fe733d5748a138a95f95"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.9/quantifai-sync-linux-amd64.tar.gz"
      sha256 "32b5f5478deb3fefe1e1afc1ff78796815bc4b098b9b6ac23d3a0a15d777b0e0"
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
