# ModReady roadmap

ModReady = the standalone one-click Bannerlord dependency installer (BLSE + the
four BUTR dependency modules). Split out of the beta-deps repo into its own
project so it versions and ships independently.

## v1.0.0 — first standalone release

- [x] Project scaffold (installer\ + scripts\ + vendored payload\).
- [x] `ModReady.iss` (own AppId, `ModReady-v<ver>` output, x64compatible).
- [x] `Build-Installer.ps1` (self-contained — validates payload, runs ISCC).
- [x] `sync-payload.ps1` (refresh the 4 deps + BLSE from a beta-deps build).
- [ ] Nexus page: description, banner (`ModReady-banner.png`), credit BUTR,
      unsigned-exe SmartScreen note. **Publish pending a connected browser.**
- [ ] Decide on code-signing the `.exe` (avoids SmartScreen) vs the description note.

## Ongoing

- Keep the bundled BLSE current as BLSE updates (re-run `sync-payload.ps1` with a
  fresh `-BlseDir`).
- Re-`sync-payload.ps1` whenever the beta-deps dependency modules change, then
  rebuild + re-ship.
- Courtesy heads-up to BUTR that the bundle redistributes BLSE (permission already
  granted; see vault note).

## Relationship to beta-deps

- beta-deps remains the **source of truth** for the four dependency module DLLs.
- ModReady **vendors a snapshot** of them (git-ignored `payload\`) and packages it.
- The legacy installer assets still live in `beta-deps\installer\` for now; retire
  them once ModReady is proven and shipping.
