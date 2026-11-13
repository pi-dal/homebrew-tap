cask "sakamoto-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.27"
  sha256 arm:   "840fc17877b350bad2207d0d401fc717e6967d50df06b952060a001f1e2dbb63",
         intel: "73414985999dca32f20aeef91c5b4b6ec22881e5aecf7077d86a0ebc5de2986f"

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
