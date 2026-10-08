# Generated from packaging/homebrew/quantifai-sync.rb in nino-chavez/quantifai-sync
# by `make formula`. Edit the template there; the tap copy is replaced on release.
class QuantifaiSync < Formula
  desc "Telemetry sync agent for Quantifai — streams AI tool usage to your dashboard"
  homepage "https://quantifai.app"
  version "0.4.7"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.7/quantifai-sync-darwin-arm64.tar.gz"
      sha256 "456eb5d22d2a315065572afbd445546c9244d9e51983da182a0c8b7528ee31b9"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.7/quantifai-sync-darwin-amd64.tar.gz"
      sha256 "2e21ee616732ac15524635e22b6df716c653c109e9e1ed3dd97259ed6de98ebc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.7/quantifai-sync-linux-arm64.tar.gz"
      sha256 "a671f455ed35c0112b6d6e807186b968854ea4384351580b1821086ed4653540"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.7/quantifai-sync-linux-amd64.tar.gz"
      sha256 "ce653c3debc8d2baaf45d013416cb581a61f2eed23ffe9808c7cd2471a6a709c"
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
