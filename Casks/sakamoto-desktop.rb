cask "sakamoto-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.22"
  sha256 arm:   "a2e60b0760f3341f4ab47a0a7d672910390aa1073bcbecdd8104c0b5fe5d55eb",
         intel: "e562dbece41c467bfdb30cf53d633272f2136433192c3c4ebc3b80e65d5bdd4b"

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
