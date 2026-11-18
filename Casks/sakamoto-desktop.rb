cask "sakamoto-desktop" do
  arch arm: "arm64", intel: "amd64"

  version "0.2.29"
  sha256 arm:   "dfe27fb8654b795f53ea45f2aa1b4cdf4095269e5093d80c7151b80bcdd4a66c",
         intel: "1fd945073f1144ca24f52723fd5dae99368f8c0a02288d65c04ff97c86582dff"

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
