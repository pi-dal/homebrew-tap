cask "sakamoto-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.23"
  sha256 arm:   "c0c5e5a82fc9556543d3745b621d8e1289beeef35ea41c46411898a54f67865e",
         intel: "3e700fd84062db147e10f3c8f604fe96ba38998682a29df408643ba3a131412d"

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
