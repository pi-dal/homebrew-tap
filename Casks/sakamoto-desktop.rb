cask "sakamoto-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.28"
  sha256 arm:   "ffce729b2f332d93e7aa181267399bae756973dba5170218dd38e1663b173c9d",
         intel: "79580d3d1eeb2157e14ec9607a84016d91f753102c64560a5f71ae57b25a5a2f"

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
