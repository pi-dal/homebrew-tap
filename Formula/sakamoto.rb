class Sakamoto < Formula
  desc "Mouse-friendly macOS sing-box TUI with Shadowrocket config import"
  homepage "https://github.com/pi-dal/sakamoto"
  url "https://github.com/pi-dal/sakamoto/archive/refs/tags/v0.2.2.tar.gz"
  sha256 "095ae279b05727b613f43dab03e7bd6d7c8b0907e5ced4d16f767731f9ec85a7"
  license "GPL-3.0-or-later"

  depends_on "go@1.26" => :build
  depends_on :macos
  depends_on "sing-box"

  def install
    system "go", "build", *std_go_args(output: bin/"sakamoto", ldflags: "-s -w"), "./cmd/sakamoto"
    system "codesign", "--force", "--sign", "-", bin/"sakamoto"
    pkgshare.install "sakamoto.example.yaml", "nodes.example.txt", "scripts", "launchd", "NOTICE.md"
    pkgshare.install "docs/portrait-license.md"
  end

  def caveats
    <<~EOS
      No VPN or privileged launchd service was started.
      Requires sing-box 1.14.2+ for native Global/Direct modes.
      Existing configs need regeneration and one planned reconnect to load mode
      rules. Updating this formula does not change an already-running TUN.
      For a new setup, copy the examples from #{pkgshare} into ~/.sakamoto,
      configure your own rules/nodes and a random API secret, then run:
        bash #{pkgshare}/scripts/install-macos.sh
      This installer explicitly asks permission before adding launchd services.
      Existing legacy VPN sessions must be migrated separately; do not replace
      a running daemon. See #{pkgshare}/scripts/migrate-legacy.sh --check.
      The About portrait's CC BY 2.0 credits are in #{pkgshare}/NOTICE.md and
      #{pkgshare}/portrait-license.md.
    EOS
  end

  test do
    assert_match "sakamoto 0.2.2", shell_output("#{bin}/sakamoto version")
  end
end
