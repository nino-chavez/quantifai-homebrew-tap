# Generated from packaging/homebrew/quantifai-sync.rb in nino-chavez/quantifai-sync
# by `make formula`. Edit the template there; the tap copy is replaced on release.
class QuantifaiSync < Formula
  desc "Telemetry sync agent for Quantifai — streams AI tool usage to your dashboard"
  homepage "https://quantifai.app"
  version "0.4.2"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.2/quantifai-sync-darwin-arm64.tar.gz"
      sha256 "5c49396aa0d3ab0756b863f02454305631ab50de8e931f97aea35d2334fac042"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.2/quantifai-sync-darwin-amd64.tar.gz"
      sha256 "b61c0596d4bef086b74b144bc2c9d0d666702c92d98573a253efd1d14b10bacb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.2/quantifai-sync-linux-arm64.tar.gz"
      sha256 "d554adf9915c66467695d67fa3867e1286e48920843a6b5279cdb98353a54a98"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.2/quantifai-sync-linux-amd64.tar.gz"
      sha256 "0d042d1152158f938d65c9811acac8abdc4b75f940a9b83eea4de9491ed84208"
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
