class Sakamoto < Formula
  desc "Mouse-friendly macOS sing-box TUI with Shadowrocket config import"
  homepage "https://github.com/pi-dal/sakamoto"
  url "https://github.com/pi-dal/sakamoto/archive/refs/tags/v0.2.21.tar.gz"
  sha256 "51cd40160bc30737a6a04312021e45299529fedb04603c1b63d6ebf6c36ceaf6"
  license "GPL-3.0-or-later"

  depends_on "go@1.26" => :build
  depends_on :macos
  depends_on "sing-box"

  def install
    ENV["CGO_ENABLED"] = "1"
    gcflags = JSON.parse((buildpath/"scripts/go-size-profile.json").read).fetch("gcflags").map do |flag|
      "-gcflags=#{flag}"
    end
    system "go", "build", *std_go_args(output: bin/"sakamoto", ldflags: "-s -w"), *gcflags, "./cmd/sakamoto"
    system "codesign", "--force", "--sign", "-", bin/"sakamoto"
    ENV["CGO_ENABLED"] = "0"
    system "go", "build", "-trimpath", "-ldflags=-s -w -X main.version=#{version}",
           "-o", "scripts/sakamoto-rescue", "./cmd/sakamoto-rescue"
    system "codesign", "--force", "--sign", "-", "scripts/sakamoto-rescue"
    system "codesign", "--verify", "--strict", "scripts/sakamoto-rescue"
    ENV["CGO_ENABLED"] = "1"
    pkgshare.install "sakamoto.example.yaml", "nodes.example.txt", "scripts", "launchd", "NOTICE.md"
    pkgshare.install "docs/portrait-license.md", "docs/dns-protection.md", "docs/s3-sync.md",
                     "docs/icloud.md", "docs/routing-sync-latency.md", "docs/desktop-learning.md",
                     "docs/configuration.md", "docs/configuration-repair.md", "docs/stability-recovery.md",
                     "docs/mobile-stability-recovery.md"
  end

  def caveats
    <<~EOS
      No VPN or privileged launchd service was started; system DNS was not changed.
      Check and repair a core crash with sakamoto repair; --check is read-only.
      Configuration recovery supports repair --fallback or --regenerate; add
      --restart to approve replacement of a running core. See
      #{pkgshare}/configuration-repair.md.
      Install the independent offline rescue helper while healthy:
        sakamoto rescue-install --check
        sakamoto rescue-install
      Running services keep their old code until separately upgraded. Inspect
      capabilities with sakamoto doctor. Use service-update --check to inspect
      the canonical supervisor; --reconnect requests a locally confirmed update.
      Protected DNS requires an explicit root-daemon upgrade/activation:
        bash #{pkgshare}/scripts/enable-dns-guard.sh
      Read #{pkgshare}/dns-protection.md before scheduling that reconnect.
      Optional iCloud rule-source sync uses include_conf: true; old nodes-only
      configurations are not expanded without explicit opt-in.
      Requires sing-box 1.14.2+ for native Global/Direct modes.
      Existing configs need regeneration and one planned reconnect to load mode
      rules. Updating this formula does not change an already-running TUN.
      Automatic learning now hot-loads verified rules without restarting the TUN.
      Regenerate and explicitly reconnect once to prepare its rule slot; older
      or unapplied configurations report deferred. Update the existing watcher
      LaunchAgent to the new binary before reloading it; running jobs retain
      their previous code. See #{pkgshare}/desktop-learning.md.
      For a new setup, copy the examples from #{pkgshare} into ~/.sakamoto,
      configure your own rules/nodes and a random API secret, then run:
        sakamoto setup --check
        sakamoto setup
      Setup explicitly asks permission before adding launchd services.
      Launchd starts only the services; after reboot, manually reconnect
      the TUN and verify protected DNS. Setup never auto-connects a VPN.
      Unidentified legacy job labels need the separate migration procedure:
      #{pkgshare}/scripts/migrate-legacy.sh --check.
      The About portrait's CC BY 2.0 credits are in #{pkgshare}/NOTICE.md and
      #{pkgshare}/portrait-license.md.
    EOS
  end

  test do
    assert_match "sakamoto 0.2.21", shell_output("#{bin}/sakamoto version")
    assert_match "sakamoto-rescue 0.2.21", shell_output("#{pkgshare}/scripts/sakamoto-rescue version")
    assert_match "service-update --check", shell_output("#{bin}/sakamoto help")
    assert_path_exists pkgshare/"configuration-repair.md"
  end
end
