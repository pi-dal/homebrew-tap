cask "sakamoto-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.30"
  sha256 arm:   "6f5ca0440ab9c6b7b70d20063998321141ad6badce694a878beb2708e807f343",
         intel: "f2ed9392fa3415c0cb1a7b7cca2aef49428b91755033a3d8877cbf1ff1e3057a"

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
