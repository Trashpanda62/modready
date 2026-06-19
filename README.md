# ModReady

**One-click Bannerlord dependency installer.** Run it once on a fresh
Mount & Blade II: Bannerlord install and it lays down everything a modlist needs
to load — then you just add the content mods you want.

What it installs:

- **BLSE** (Bannerlord Software Extender) into `bin\Win64_Shipping_Client\` — MIT,
  © BUTR, bundled with permission.
- The **four BUTR dependency modules** into `Modules\`:
  `Bannerlord.Harmony`, `Bannerlord.UIExtenderEx`, `Bannerlord.ButterLib`,
  `Bannerlord.MBOptionScreen` (clean-room [BetaDeps](https://www.nexusmods.com/mountandblade2bannerlord/mods/11274) builds).

It does **not** ship the BetaDeps framework module itself — ModReady is the
dependency stack only. (`BetaDeps.Foundation.dll` still ships inside each
dependency's `bin\` — it's their shared resolve-hook shim and they can't load
without it.)

## Layout

```
installer\
  ModReady.iss          Inno Setup script (the installer definition)
  ModReady-banner.png   Nexus banner art
  payload\              Vendored snapshot the installer bundles (git-ignored)
    Modules\            The 4 dependency module folders
    BLSE\               BLSE binaries (flat)
    LICENSES\           BLSE MIT + third-party MIT notices
scripts\
  Build-Installer.ps1   Validate payload + compile ModReady.iss -> dist\
  sync-payload.ps1      Refresh payload\ from a built beta-deps repo
dist\                   Output: ModReady-v<ver>.exe (git-ignored)
```

## Build it

One-time: install **Inno Setup 6** (https://jrsoftware.org/isdl.php — provides `ISCC.exe`).

```powershell
cd C:\dev\modready
# (first time, or after new module builds) refresh the bundled snapshot:
.\scripts\sync-payload.ps1            # pulls from C:\dev\beta-deps\dist\Modules + BLSE
# compile the installer:
.\scripts\Build-Installer.ps1 -Version 1.0.0
```

Output: `dist\ModReady-v1.0.0.exe`.

The `payload\` snapshot and `dist\` outputs are **git-ignored** — the source of
truth for the bundled modules is the beta-deps repo; ModReady just vendors and
packages them.

## Install behavior

- Auto-detects the Bannerlord install (Steam registry → common path → user browse)
  and validates the folder contains `bin\Win64_Shipping_Client\Bannerlord.exe`.
- `ArchitecturesInstallIn64BitMode=x64compatible` (installs under ARM64/x64 emulation too).
- Optional desktop shortcut to the BLSE launcher + offer to launch on finish.
- Uninstall removes the persistent `CREST_SHOW_STUBS` user env var if present.

## Licensing / credit

BLSE is redistributed under its **MIT license** (© 2021-2022 BUTR), shown on the
installer's license page and copied to `Modules\Bannerlord.Harmony\licenses\`.
Third-party MIT notices (0Harmony, Mono.Cecil, MonoMod.*, Newtonsoft.Json) ship
in the same folder. Credit BUTR as the creators of BLSE and the BUTR stack.

## Ship

Distribute on **Nexus** (not Steam Workshop — Workshop hosts modules, not
installers). Note the unsigned-exe SmartScreen warning in the description, or
code-sign the `.exe` to avoid it.
