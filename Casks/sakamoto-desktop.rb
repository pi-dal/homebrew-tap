cask "sakamoto-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.24"
  sha256 arm:   "dabb5000567fa523b345483ad97a8e8e95823cbc696efed83ae01dbf771a7e44",
         intel: "835f9b280b2aec36e45098a3b1cbd8d53529c50af50e72bc3855efb3779b93b7"

  url "https://github.com/pi-dal/sakamoto/releases/download/desktop-v#{version}/sakamoto-menubar-v#{version}-darwin-#{arch}.zip"
  name "Sakamoto"
  desc "Menu bar connection client with node and routing controls"
  homepage "https://github.com/pi-dal/sakamoto"

  livecheck do
    url :url
    regex(/^desktop-v(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on macos: :monterey

  app "Sakamoto.app"

  caveats <<~EOS
    Open Sakamoto from Applications. Configuration and background services
    are set up separately using the bundled TUI or the sakamoto CLI formula.
    Installation does not start a tunnel or install privileged services.
  EOS
end
