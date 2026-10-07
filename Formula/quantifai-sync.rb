# Generated from packaging/homebrew/quantifai-sync.rb in nino-chavez/quantifai-sync
# by `make formula`. Edit the template there; the tap copy is replaced on release.
class QuantifaiSync < Formula
  desc "Telemetry sync agent for Quantifai — streams AI tool usage to your dashboard"
  homepage "https://quantifai.app"
  version "0.4.5"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.5/quantifai-sync-darwin-arm64.tar.gz"
      sha256 "11abc431b818158798fa5ba9b5c10ea3da4ed79edafc31235bc1ee094455c20c"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.5/quantifai-sync-darwin-amd64.tar.gz"
      sha256 "25eea9ec11e128bfe9099d245a42d8fc3aca0822a005bbcafb50abc18a6fe717"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.5/quantifai-sync-linux-arm64.tar.gz"
      sha256 "3fc39c429887d145b358c922a8d540ef4527920b2b8546d8d08ee29ce0cd647d"
    else
      url "https://github.com/nino-chavez/quantifai-sync/releases/download/v0.4.5/quantifai-sync-linux-amd64.tar.gz"
      sha256 "252513344c7a8809f09552ace2d7dc07c42d6a559bb2690c8c6393c18916208f"
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
