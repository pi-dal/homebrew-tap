# pi-dal Homebrew tap

## sakamoto

A macOS terminal controller for [sing-box](https://github.com/SagerNet/sing-box), with Shadowrocket `.conf` import. Source, documentation, and license: [pi-dal/sakamoto](https://github.com/pi-dal/sakamoto).

```bash
brew install pi-dal/tap/sakamoto
sakamoto version
```

Installation **does not** create a privileged service or start/replace a VPN. For a fresh configuration, copy the sample files from `$(brew --prefix)/share/sakamoto` to `~/.sakamoto`, set your own rules and nodes and a random API secret, generate a config in the TUI, and check it with `sing-box check`. Only then, if desired, run:

```bash
bash "$(brew --prefix)/share/sakamoto/scripts/install-macos.sh"
```

The installer asks before creating a root launchd service. **Do not run it over an active legacy daemon.** Follow [the migration guide](https://github.com/pi-dal/sakamoto/blob/main/docs/migration.md) instead. Installing or upgrading the formula does not migrate existing services or reconnect their TUN.

To upgrade later: `brew update && brew upgrade pi-dal/tap/sakamoto`. Formula builds from a versioned source archive using Homebrew's Go build dependency; sing-box is a runtime dependency. The tap publishes no user nodes, API credentials, or generated configurations.
