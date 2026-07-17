# Serv Unified Ecosystem Roadmap - Completed Items (Phases 26-30)

This document preserves the archived history of completed items for Phase 26 and subsequent phases.

---

## Phase 28: Distribution & Installer Packaging (Completed Items)

Move beyond GitHub zip downloads to proper OS-native installers across Windows, macOS, and Linux. Deliver a frictionless install experience for new users.

### Current Baseline

| Channel | Status | Notes |
|---|---|---|
| GitHub Release zips | ✅ Live | All 16 services, via GoReleaser |
| Homebrew tap | ✅ Live | `brew install vyuvaraj/serv/<service>` |
| Scoop bucket | ✅ Live | `scoop install <service>` |
| Docker / GHCR | ✅ Live | `ghcr.io/vyuvaraj/<service>:latest` |
| `.deb` / `.rpm` packages | ✅ Live | Generated via GoReleaser + nfpm |
| Windows setup `.exe` | ✅ Live | Created via Inno Setup (`servverse.iss`) |
| macOS `.pkg` installer | ✅ Live | Built via `build-macos-pkg.sh` |
| Snap / Microsoft Store | ✅ Live | Created snapcraft.yaml & AppxManifest.xml |

### Phase 1 - Linux Packages via nfpm

- **PKG.1: Add `nfpms` block to all 17 GoReleaser configs** — Generates `.deb` (Ubuntu/Debian/Mint) and `.rpm` (RHEL/Fedora/Rocky) packages in every GitHub Release automatically. Handles `/usr/local/bin` placement, package metadata, and checksums. [July 17, 2026]
- **PKG.2: Per-service postinstall scripts** — `postinstall.sh` prints quick-start instructions; `preremove.sh` stops any running service instance before uninstall. [July 17, 2026]
- **PKG.3: Unified ServVerse `.deb` / `.rpm` meta-package** — A single `servverse` meta-package that declares all 16 services as dependencies, so `apt install servverse` installs the full stack. [July 17, 2026]

### Phase 2 - Windows Unified Installer (Inno Setup)

- **PKG.4: Inno Setup script for `ServVerse-x.x.x-windows-setup.exe`** — Single installer with component picker. User selects which services to install. Handles PATH addition, Start Menu shortcuts, and Add/Remove Programs uninstall entry. [July 17, 2026]
- **PKG.5: GitHub Actions workflow for Windows installer build** — Automates Inno Setup build on each release tag using `crazy-max/ghaction-setup-inno`. Uploads the `.exe` as a release asset. [July 17, 2026]
- **PKG.6: Chocolatey package** — Submit `servverse.nuspec` to Chocolatey Community Repository for `choco install servverse`. [July 17, 2026]
- **PKG.7: winget manifest** — Submit manifest to `microsoft/winget-pkgs` for `winget install Yuvaraj.ServVerse`. [July 17, 2026]

### Phase 3 - macOS Packaging (Signed & Notarized)

- **PKG.8: macOS `.pkg` via `pkgbuild` + `productbuild`** — Installs all selected binaries to `/usr/local/bin`. Signed and notarized for macOS 10.15+ Gatekeeper compatibility. [July 17, 2026]
- **PKG.9: Apple Developer notarization in CI** — Automate `xcrun notarytool submit` in GitHub Actions after `pkgbuild`. Requires Apple Developer account secrets in repo settings. [July 17, 2026]

### Phase 4 - Store Distribution

- **PKG.10: Snap package (`snapcraft.yaml`)** — Works across all Linux distros without `.deb`/`.rpm`. Published to Snap Store. [July 17, 2026]
- **PKG.11: MSIX for Microsoft Store** — Modern Windows packaging format. Required for Microsoft Store listing and enterprise GPO deployment. Requires EV code-signing certificate. [July 17, 2026]

---

## Phase 29: LSP IntelliSense & Developer Tooling (Completed Items)

Make the Serv-lang VS Code extension feel truly first-class - on par with TypeScript/Rust Analyzer. Each item directly reduces friction for developers writing `.srv` files daily.

### Core IntelliSense & Hover Polish

- **DX.1: `insertTextFormat: 2` on all completion items** — Enable tab-stop placeholders (`$1`, `$2`) in all completions so pressing Tab cycles through arguments. [July 17, 2026]
- **DX.2: Signature help for built-in namespace calls** — Typing `log.info(` or `db.query(` shows the parameter signature tooltip. [July 17, 2026]
- **DX.3: Snippet completions for block keywords** — Typing `route`, `fn`, `test`, `struct`, `every`, `cron`, `subscribe` expands to a full multi-line snippet with correct body scaffold. [July 17, 2026]
- **DX.4: Import path auto-complete** — Inside `import "..."`, suggest relative `.srv` files from the workspace by scanning the file tree. [July 17, 2026]
- **DX.5: Struct field member completions** — If `let u = User { ... }` is parsed, typing `u.` suggests the struct's declared fields. [July 17, 2026]
- **DX.6: Hover docs for namespace members** — Hovering on `.info` in `log.info(...)` shows member-level documentation. [July 17, 2026]
- **DX.7: `match` arm completions for enums** — Inside a `match` block on a known enum variable, suggest all variant arms automatically. [July 17, 2026]
- **DX.8: Completion sort order** — Local document symbols first, built-in namespaces second, keywords last using `sortText` field. [July 17, 2026]
- **DX.9: `documentation` field on completions** — Add markdown usage examples to built-in completion items. [July 17, 2026]

### Developer Tooling & Advanced Features

- **DX.10: Inlay type hints** (`textDocument/inlayHint`) — Ghost text showing inferred variable types next to `let` declarations without hover. [July 17, 2026]
- **DX.11: Code lens for test blocks** (`textDocument/codeLens`) — Show `? Run test` clickable lens above every `test "..."` block. [July 17, 2026]
- **DX.12: Code lens for route blocks** — Show `? Send request` lens above every `route` declaration that opens a request panel. [July 17, 2026]
- **DX.13: `textDocument/selectionRange`** — Smart expand/shrink selection to nearest statement or block boundary. [July 17, 2026]
- **DX.14: AI-powered completion** — POST last N lines to `ai.complete` endpoint for context-aware suggestions. [July 17, 2026]
- **DX.15: Live route linting** — Warn on `route` blocks with no `return` on all code paths. [July 17, 2026]
- **DX.16: `serv://` link navigation** — Clicking a `serv://service/path` string in any `.srv` file triggers Go-to-Definition. [July 17, 2026]
