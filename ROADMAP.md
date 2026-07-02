# ModReady roadmap

ModReady = the standalone Bannerlord dependency pack: the four BUTR dependency
modules (Harmony, UIExtenderEx, ButterLib, MCM). Split out of the modready repo
into its own project so it versions and ships independently.

**2026-06-19 — dropped BLSE from the bundle.** Nexus's scanner flags any archive
containing executables, and BLSE ships three .exe. ModReady is now deps-only and
lists BLSE as a required mod (which also keeps BLSE updatable on its own). The
manual-install **zip** (no executables) is the Nexus artifact; the Inno `.exe`
installer stays for local use only (Nexus flags installers regardless).

**2026-06-30 — BLSE is no longer required.** Verified the dependency stack loads
standalone through the native launcher (no BLSE): clean boot to the main menu on
both Steam (.NET Framework) and Game Pass (.NET 6/GDK), `MarkBootSuccessful` in
`runtime.log`. The `ModReady.Foundation.dll` resolve-hook shim in each module's
`bin\` is what resolves the deps without BLSE's loader. v1.0.5 and v1.0.6 module
files are byte-identical — this is documentation-only. `Build-Zip.ps1`'s bundled
README is already updated to "BLSE optional"; the Nexus page description was updated
on 2026-06-30. **TODO at v1.1.0:** bring `CHANGELOG.md` + `README.md` to BLSE-optional,
and flip BLSE from required -> recommended in the Nexus requirements (mod 11274).

## v1.0.0 — first standalone release

- [x] Project scaffold (installer\ + scripts\ + vendored payload\).
- [x] `ModReady.iss` (own AppId, `ModReady-v<ver>` output, x64compatible).
- [x] `Build-Installer.ps1` (self-contained — validates payload, runs ISCC).
- [x] `sync-payload.ps1` (refresh the 4 deps + BLSE from a modready build).
- [ ] Nexus page: description, banner (`ModReady-banner.png`), credit BUTR,
      unsigned-exe SmartScreen note. **Publish pending a connected browser.**
- [ ] Decide on code-signing the `.exe` (avoids SmartScreen) vs the description note.

## Ongoing

- Keep the bundled BLSE current as BLSE updates (re-run `sync-payload.ps1` with a
  fresh `-BlseDir`).
- Re-`sync-payload.ps1` whenever the modready dependency modules change, then
  rebuild + re-ship.
- Courtesy heads-up to BUTR that the bundle redistributes BLSE (permission already
  granted; see vault note).

## Relationship to modready

- modready remains the **source of truth** for the four dependency module DLLs.
- ModReady **vendors a snapshot** of them (git-ignored `payload\`) and packages it.
- The legacy installer assets still live in `modready\installer\` for now; retire
  them once ModReady is proven and shipping.
