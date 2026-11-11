cask "sakamoto-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.26"
  sha256 arm:   "49faccaca211033c05a920df65eb7b8d853c252773096f6efdab202af9ae72d6",
         intel: "0df19fc55463a1dc89785f51db52b04954c1416c7b3b23a99bd679685e5fc8f0"

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
