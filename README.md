# ModReady

**The Bannerlord dependency modules every modern mod needs, in one download.**
Ships `Bannerlord.Harmony`, `Bannerlord.UIExtenderEx`, `Bannerlord.ButterLib`,
and `Bannerlord.MBOptionScreen` (MCM) — clean-room
[ModReady](https://www.nexusmods.com/mountandblade2bannerlord/mods/11274) builds.

## BLSE — optional (recommended, not bundled)

ModReady loads on its own through the game's **native launcher**, so BLSE is **not**
required. BLSE is still recommended — it gives better crash reports and the early
loading some other mods rely on. Get it from its
[Nexus page](https://www.nexusmods.com/mountandblade2bannerlord/mods/1) if you want it.

Why not bundle it: BLSE ships executables, and re-hosting them inside the download
gets the file flagged unsafe by Nexus's malware scanner. Keeping BLSE as its own
mod also means it stays up to date on its own (a bundled copy would freeze).

It also does **not** ship the ModReady framework module — this is the dependency
stack only. (`ModReady.Foundation.dll` still ships inside each dependency's `bin\`
— it's their shared resolve-hook shim and they can't load without it.)

## Layout

```
installer\
  ModReady.iss          Inno Setup script (deps-only local installer; optional)
  ModReady-banner.png   Nexus banner art
  payload\              Vendored snapshot (git-ignored)
    Modules\            The 4 dependency module folders (no BLSE, no ModReady)
    LICENSES\           Third-party MIT notices
scripts\
  sync-payload.ps1      Refresh payload\ from a built modready repo
  Build-Zip.ps1         Build the manual-install zip (the Nexus artifact)
  Build-Installer.ps1   Build a local Inno installer (optional)
dist\                   Output: ModReady-v<ver>.zip (git-ignored)
```

## Build it

```powershell
cd C:\dev\modready
# (first time, or after new module builds) refresh the bundled snapshot:
.\scripts\sync-payload.ps1            # pulls the 4 deps from C:\dev\modready\framework\dist\Modules
# build the manual-install zip (this is what goes on Nexus):
.\scripts\Build-Zip.ps1 -Version 1.0.0
# optional: a local Inno installer (Nexus flags .exe installers, so not for Nexus):
.\scripts\Build-Installer.ps1 -Version 1.0.0
```

`payload\` and `dist\` are **git-ignored** — the modready repo is the source of
truth for the module DLLs; ModReady just vendors and packages them.

## Install (for users)

1. Extract `ModReady-v<ver>.zip`'s `Modules` folder into your Bannerlord folder
   (the one containing `bin` and `Modules`), merging when asked.
2. Enable Harmony / UIExtenderEx / ButterLib / MCM in the launcher, then Play —
   through the native launcher, or BLSE (optional) if you installed it.

The game auto-sorts these by their declared dependencies; the order above is just
the order they end up in (Harmony → UIExtenderEx → ButterLib → MCM), all above Native.

## Ship

Distribute on **Nexus** as the manual-install **zip** (no executables → not
flagged). List **BLSE** as a required mod. Don't upload the Inno `.exe` to Nexus —
its scanner flags installer executables regardless of contents.

## Licensing / credit

The bundled dependency DLLs are MIT (0Harmony, Mono.Cecil, MonoMod.\*,
Newtonsoft.Json); notices ship in `licenses\`. The BUTR dependency stack and BLSE
are the work of **BUTR** (https://github.com/BUTR).
