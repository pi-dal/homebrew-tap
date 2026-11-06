cask "sakamoto-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.25"
  sha256 arm:   "3c0c0577c4eb849ad57f211ef1e4e3ce04bb0fa9c63e9bfdc54d5fdf7bb96963",
         intel: "d23426dfacbb97d08a31ebfbdcb819e196d4981e779a773cb92cb6bad775340c"

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
