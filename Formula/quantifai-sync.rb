# Generated from packaging/homebrew/quantifai-sync.rb in nino-chavez/quantifai-sync
# by `make formula`. Edit the template there; the tap copy is replaced on release.
class QuantifaiSync < Formula
  desc "Telemetry sync agent for Quantifai — streams AI tool usage to your dashboard"
  homepage "https://quantifai.app"
  version "0.4.1"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.1/quantifai-sync-darwin-arm64.tar.gz"
      sha256 "3ba911a6c36c3c390ddf6ea8a9cbd0f6eccbf837dd60d18a3f975d4a0fddaaaf"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.1/quantifai-sync-darwin-amd64.tar.gz"
      sha256 "8bb390939cd0a0b544da8f3f5ed5297dd0672dd0b140d5feac096ba66cb8806b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.1/quantifai-sync-linux-arm64.tar.gz"
      sha256 "009772a9561a526f887f231c3b4308112f481e3970f9bf79a1337e8900f1c95d"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.1/quantifai-sync-linux-amd64.tar.gz"
      sha256 "cdeda19f218289aa4a3f493931fcb22c21730ac0ac3c3a85062a91c692caf906"
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
