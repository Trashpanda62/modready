# ModReady

**The Bannerlord dependency modules every modern mod needs, in one download.**
Ships `Bannerlord.Harmony`, `Bannerlord.UIExtenderEx`, `Bannerlord.ButterLib`,
and `Bannerlord.MBOptionScreen` (MCM) — clean-room
[ModReady](https://www.nexusmods.com/mountandblade2bannerlord/mods/11274) builds.

**Get it:** [Nexus](https://www.nexusmods.com/mountandblade2bannerlord/mods/11274) ·
[Steam Workshop](https://steamcommunity.com/profiles/76561198087292666/myworkshopfiles/?appid=261550) ·
[Releases here](https://github.com/Trashpanda62/modready/releases)
**Support the work / commission a mod:** [patreon.com/Trashpanda62](https://www.patreon.com/Trashpanda62?utm_source=github)

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
framework\              The source repo (own git) — all module code + build scripts
workshop\               Steam Workshop update XMLs + upload .bat
docs\                   Release texts, runbooks
```

## Build it

```powershell
cd C:\dev\modready\framework
# stage dist\Modules\ + the 5-folder bundle zip (release-gated):
powershell scripts\Build-Phase1.ps1 -Version <X.Y.Z> -SkipDeploy
# slice the 4 standalone dependency zips from the same staged tree:
powershell scripts\Package-Optional-Deps.ps1 -Version <X.Y.Z>
```

Artifacts land in `framework\dist\` (git-ignored). No installer — Nexus flags
`.exe` uploads, so distribution is zips only.

## Install (for users)

1. Extract `ModReady-v<ver>.zip`'s `Modules` folder into your Bannerlord folder
   (the one containing `bin` and `Modules`), merging when asked.
2. Enable Harmony / UIExtenderEx / ButterLib / MCM in the launcher, then Play —
   through the native launcher, or BLSE (optional) if you installed it.

The game auto-sorts these by their declared dependencies; the order above is just
the order they end up in (Harmony → UIExtenderEx → ButterLib → MCM), all above Native.

## Ship

Distribute on **Nexus** as the manual-install **zips** (no executables → not
flagged): the 5-folder bundle + 4 optional dependency zips from `framework\dist\`.
Full runbook: `framework\docs\SHIP-IT.md` (trigger: "ship it"). BLSE is optional,
not required, and never bundled.

## Licensing / credit

The bundled dependency DLLs are MIT (0Harmony, Mono.Cecil, MonoMod.\*,
Newtonsoft.Json); notices ship in `licenses\`. The BUTR dependency stack and BLSE
are the work of **BUTR** (https://github.com/BUTR).
