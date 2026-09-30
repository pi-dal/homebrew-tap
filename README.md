# pi-dal Homebrew tap

Homebrew packages for pi-dal projects are maintained here rather than in the application repositories.

| Project | Install | Platform |
| --- | --- | --- |
| [Agent Explorer](https://github.com/pi-dal/agent-explorer) | `brew install --cask pi-dal/tap/agent-explorer` | macOS Apple Silicon |
| [VoicePi](https://github.com/pi-dal/VoicePi) | `brew install --cask pi-dal/tap/voicepi` | macOS 14+ |
| [sakamoto](https://github.com/pi-dal/sakamoto) | `brew install pi-dal/tap/sakamoto` | macOS |

The tap is added automatically on first install. For later updates, run `brew update && brew upgrade` (or specify the package). The casks use published release assets and their SHA-256 checksums; update them here when publishing new releases.

## Agent Explorer

Install the macOS Apple Silicon desktop app from [agent-explorer](https://github.com/pi-dal/agent-explorer):

```bash
brew install --cask pi-dal/tap/agent-explorer
```

The release is ad-hoc signed, not notarized; macOS may require **Open Anyway** in Privacy & Security on first launch. Intel macOS is not supported by this cask.

## VoicePi

Install the macOS 14+ menu-bar app from [VoicePi](https://github.com/pi-dal/VoicePi):

```bash
brew install --cask pi-dal/tap/voicepi
```

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

Current formula: **sakamoto v0.2.2**. Native Rule/Global/Direct modes require sing-box 1.14.2+, regeneration and one planned reconnect for older configs; subsequent mode switches apply to new connections without restarting the TUN. The user-level watcher exposes `sakamoto recover` to queue fresh group tests for integrations such as pi-proxy-guard, without restarting the TUN. To upgrade later: `brew update && brew upgrade pi-dal/tap/sakamoto`. It builds a versioned source archive with Homebrew's Go build dependency; sing-box is a runtime dependency. No user nodes, API credentials, or generated configurations are published. The separately licensed About portrait's credits are included in the installed `NOTICE.md` and `portrait-license.md`.

**Platform status:** Apple Silicon installation is tested in clean macOS CI. Intel installation is not verified for this release: Homebrew currently has no Intel bottle for the required recent sing-box, and building that upstream dependency from source can take a very long time. Do not treat the macOS Intel path as tested.
