cask "sakamoto-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.20"
  sha256 arm:   "8e1f2e931faf171726ee246347f46df9933d42166fcbfcd37c26d2a06da10d48",
         intel: "a149efffb247f8195d31f7f6e91fec14bfc2a8cfe456f7b0ef42bcbdc1098018"

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
