cask "sakamoto-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.31"
  sha256 arm:   "22c99d4637f88e4680af337e296b53cf02033c7303f122b0d6bd3e5eb0103c3e",
         intel: "35dda6b59352c162d3da33c02b5dbfb94d35df7448bfba5c15ec2fcd5cec89c2"

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
