class Sakamoto < Formula
  desc "Mouse-friendly macOS sing-box TUI with Shadowrocket config import"
  homepage "https://github.com/pi-dal/sakamoto"
  url "https://github.com/pi-dal/sakamoto/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "9f68b1347d45a7e6dc241af1fa8e77c095bf92826ee53a4a35825fa3068573fc"
  license "GPL-3.0-or-later"

  depends_on "go@1.26" => :build
  depends_on :macos
  depends_on "sing-box"

  deny_network_access!

  def fetch
    system "go", "mod", "download"
  end

  def install
    system "go", "build", *std_go_args(output: bin/"sakamoto", ldflags: "-s -w"), "./cmd/sakamoto"
    system "codesign", "--force", "--sign", "-", bin/"sakamoto"
    pkgshare.install "sakamoto.example.yaml", "nodes.example.txt", "scripts", "launchd"
  end

  def caveats
    <<~EOS
      No VPN or privileged launchd service was started.
      For a new setup, copy the examples from #{pkgshare} into ~/.sakamoto,
      configure your own rules/nodes and a random API secret, then run:
        bash #{pkgshare}/scripts/install-macos.sh
      This installer explicitly asks permission before adding launchd services.
      Existing legacy VPN sessions must be migrated separately; do not replace
      a running daemon. See #{pkgshare}/scripts/migrate-legacy.sh --check.
    EOS
  end

  test do
    assert_match "sakamoto 0.1.0", shell_output("#{bin}/sakamoto version")
  end
end
