# ModReady v2.0.0 release texts

ModReady steps aside from the BUTR dependency stack. It no longer ships modules or
assemblies named Bannerlord.Harmony / Bannerlord.UIExtenderEx / Bannerlord.ButterLib /
MCM. It is now one optional module, `ModReady`, that runs on top of BUTR's real
Bannerlord.Harmony.

Release zip: `C:\dev\modready\framework\dist\v2\ModReady-v2.0.0.zip`

---

## 1. Nexus — main description (replace the whole description, BBCode)

```bbcode
[size=5][b]ModReady[/b][/size]
Save-load and crash guards for Bannerlord. An optional add-on that runs on top of BUTR's dependency stack.

[size=4][b]Important: ModReady no longer ships Harmony, UIExtenderEx, ButterLib or MCM[/b][/size]
BUTR's originals are updated for Bannerlord v1.4.8. Running ModReady's old copies next to them (same module IDs) was causing launcher and save crashes, so from v2.0.0 ModReady stops shipping its own versions.

[b]If you used ModReady v1.x:[/b]
[list]
[*]Delete these folders from your Modules folder if they came from ModReady: Bannerlord.Harmony, Bannerlord.UIExtenderEx, Bannerlord.ButterLib, Bannerlord.MBOptionScreen (Steam: unsubscribe from the old ModReady Harmony / UIExtenderEx / ButterLib / MCM items)
[*]Install BUTR's originals (links below)
[*]Install ModReady v2.0.0 if you want the save-load guards
[/list]

[size=4][b]What ModReady does[/b][/size]
[list]
[*]Removes corrupt leftover troops (e.g. orphaned retinues) from party rosters on load, so the map and party screens stop freezing
[*]Guards the tooltip text lookup and map-bar refresh so a broken mod can't hang the campaign map on load
[*]Fixes the main-menu "Continue" save-load loop with mismatched modules
[*]Loads mods that ship several per-game-version DLLs without corrupting the save system
[*]Catches mod patches built against older game versions and names the culprit mod in runtime.log
[/list]

[size=4][b]Requirements[/b][/size]
[list]
[*][url=https://www.nexusmods.com/mountandblade2bannerlord/mods/2006]Harmony[/url] by BUTR
[/list]
Load order: Harmony, then ModReady, then your other mods. Bannerlord v1.4.0 – v1.4.8, Steam.

[size=4][b]Licensing and provenance[/b][/size]
ModReady is MIT licensed and is not affiliated with or endorsed by BUTR.

[b]Source code — both projects:[/b]
[list]
[*]ModReady (all code in this download): [url=https://github.com/Trashpanda62/modready-framework]github.com/Trashpanda62/modready-framework[/url]
[*]Bannerlord.UIExtenderEx (BUTR, LGPL): [url=https://github.com/BUTR/Bannerlord.UIExtenderEx]github.com/BUTR/Bannerlord.UIExtenderEx[/url]
[/list]

[b]Changes stated:[/b]
[list]
[*]ModReady v1.0.0 – v1.1.0 shipped modules named Bannerlord.Harmony, Bannerlord.UIExtenderEx, Bannerlord.ButterLib and Bannerlord.MBOptionScreen (MCM). These were ModReady's own re-implementations of those projects' public APIs, written so mods built against them would load.
[*]v2.0.0 removes all four. ModReady no longer ships any module, assembly, ID or version number belonging to BUTR's projects, and no UIExtenderEx code of any kind. The v1.x files have been removed from this page.
[*]The v2.0.0 download contains only ModReady.Harmony.dll and ModReady.Foundation.dll (both ModReady's own code, MIT) plus SubModule.xml and LICENSE. Harmony itself is supplied at runtime by BUTR's Harmony module.
[/list]

BUTR's dependency stack (get these from BUTR):
[list]
[*][url=https://github.com/BUTR/Bannerlord.Harmony]Harmony[/url] · [url=https://github.com/BUTR/Bannerlord.UIExtenderEx]UIExtenderEx[/url] · [url=https://github.com/BUTR/Bannerlord.ButterLib]ButterLib[/url] · [url=https://github.com/Aragas/Bannerlord.MBOptionScreen]MCM[/url]
[/list]
```

## 2. Nexus — file upload

- File name: `ModReady v2.0.0`
- Version: `2.0.0`
- Category: Main file
- File description (<=230 chars):

  > Standalone save-load and crash guards that run on BUTR's Harmony. No longer ships Harmony, UIExtenderEx, ButterLib or MCM — use BUTR's originals. Fixes crashes from mixing ModReady's old copies with BUTR v1.4.8 builds.

- Files tab: **delete or archive every v1.x file** (they contain the BUTR-named modules the moderator flagged).
- Requirements tab: add BUTR Harmony (Nexus 2006) as a requirement; remove anything else.
- Permissions: match the MIT licence (allow modification/redistribution with credit).

## 3. CHANGELOG / Nexus changelog / GitHub release

```
## v2.0.0 — 2026-11-02

Compatible with Bannerlord 1.4.0 – 1.4.8 (Steam). Requires BUTR's Harmony.

- ModReady no longer ships Harmony, UIExtenderEx, ButterLib or MCM — use BUTR's originals, which are updated for 1.4.8
- Fixed launcher and save crashes from ModReady's old dependency modules clashing with BUTR's UIExtenderEx 3 / MCM 5.13 / ButterLib 2.12
- ModReady is now one optional module that runs on top of BUTR's Harmony
- Roster repair, tooltip-text and map-bar guards moved into the ModReady module
- Game Pass: not supported in v2.0.0 (BUTR's stack covers Game Pass on its own)
```

## 4. Steam Workshop

- Old items 3747619959 / 3747620095 / 3747620149 / 3747620191 → retired notice:
  `workshop\WorkshopRetire-{Harmony,UIExtenderEx,ButterLib,MCM}.xml`
- New ModReady item: **3832648631** (https://steamcommunity.com/sharedfiles/filedetails/?id=3832648631), created 2026-11-02; future updates use `workshopWorkshopUpdate-ModReady.xml`
  it uploads, add BUTR Harmony 2859188632 as a Required Item on the item page)
- Run all five: `workshop\Ship-V2-Workshop.bat`

## 5. Reply to Nexus staff (via "report this file" on 11274) — DRAFT, Steve sends

> Thanks for the notice. I've addressed it by removing the problem entirely rather than
> documenting around it.
>
> ModReady v1.x shipped modules named Bannerlord.UIExtenderEx (plus Harmony, ButterLib and
> MCM). As of v2.0.0, ModReady no longer ships any module, assembly, ID or version number
> belonging to BUTR's projects. I've removed every v1.x file from the page. The only file
> now is v2.0.0, which contains ModReady.Harmony.dll and ModReady.Foundation.dll (my own
> MIT code) and requires BUTR's original Harmony.
>
> The description now has a "Licensing and provenance" section with source links for both
> projects (my repo, github.com/Trashpanda62/modready-framework, and
> github.com/BUTR/Bannerlord.UIExtenderEx) and a full statement of the changes.
>
> If anything else on the page still needs changing, tell me and I'll change it.
