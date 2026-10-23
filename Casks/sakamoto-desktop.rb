cask "sakamoto-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.19"
  sha256 arm:   "1a44dd26d48bf7462d3423e4e22f7c025652e76e8c5b8d2021d3d9c91ecd2dc4",
         intel: "66058b125e4dc6ab4153583637bfe4fbafc6114e250365886b5e12fb8a626708"

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
