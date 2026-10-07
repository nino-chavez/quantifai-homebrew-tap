# Generated from packaging/homebrew/quantifai-sync.rb in nino-chavez/quantifai-sync
# by `make formula`. Edit the template there; the tap copy is replaced on release.
class QuantifaiSync < Formula
  desc "Telemetry sync agent for Quantifai — streams AI tool usage to your dashboard"
  homepage "https://quantifai.app"
  version "0.4.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.3/quantifai-sync-darwin-arm64.tar.gz"
      sha256 "a17cc0b2fb689edd3d6c7cad8cfb12c58731e47a34723801eda3803c82d3efd5"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.3/quantifai-sync-darwin-amd64.tar.gz"
      sha256 "12d88529fd66b0ef07d9b0d4b77a1ac3fc04e9e944fb6c730d869f7ca60d263b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.3/quantifai-sync-linux-arm64.tar.gz"
      sha256 "ae13fdef55c68b8dbc1d799aeb00a6a0f289adc912a6c16fcc182b6fdad47ff6"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.3/quantifai-sync-linux-amd64.tar.gz"
      sha256 "665163be67b1cd6f2c06e16ab7069e96283f85ecbe0e446c07941cc5befbd686"
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
