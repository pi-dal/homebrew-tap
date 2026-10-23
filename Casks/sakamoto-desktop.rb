cask "sakamoto-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.21"
  sha256 arm:   "f8174caa19d64bf2514a018429718b9752f01dd1ed727d7df75eb2f66dccb9e1",
         intel: "3968102e7eca68233dc88f2b6a6300fc9558fc983c669f936336160f222fcb47"

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
