# Generated from packaging/homebrew/quantifai-sync.rb in nino-chavez/quantifai-sync
# by `make formula`. Edit the template there; the tap copy is replaced on release.
class QuantifaiSync < Formula
  desc "Telemetry sync agent for Quantifai — streams AI tool usage to your dashboard"
  homepage "https://quantifai.app"
  version "0.4.8"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.8/quantifai-sync-darwin-arm64.tar.gz"
      sha256 "6d2f016415bb9bac0c0ad645b77707864e466e6a702fc0837246ae09699956fe"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.8/quantifai-sync-darwin-amd64.tar.gz"
      sha256 "2dd90e948375b1de8e8bb5b335c41686765f73d50eab76135e30a5dc4bacadf1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.8/quantifai-sync-linux-arm64.tar.gz"
      sha256 "8ffc6e238a0c27186207c029c04d957d70600398d0d2244f7157ff3366936e1c"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.8/quantifai-sync-linux-amd64.tar.gz"
      sha256 "9fce2cce96438fb850cf7303e4e600126af23ab61bf4663fdc28154ac14abc34"
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
