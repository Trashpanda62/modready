# ModReady v1.0.6 — release texts

Release zips: `C:\dev\modreadyramework\dist\ModReady-v1.0.6.zip` (5-folder bundle) + 4 optional dep zips in the same folder.
Nexus mod 11274. Bug-fix release after v1.0.5.

---

## 1. Nexus changelog (BBCode — paste into the mod's Changes tab)

```bbcode
[b]v1.0.6[/b]
[list]
[*]Fixed startup "dependency conflict" crash with mods using the newer UIExtenderEx insert API (AI Influence 5.0.7 etc.)
[*]Windows-blocked (mark-of-the-web) mod DLLs now load automatically - no more manual unblocking
[*]Fixed saves made with official BUTR modules freezing on load
[*]Fixed dropdown settings showing as checkboxes and losing your selection
[*]Fixed group on/off toggles missing from Mod Options
[*]Fixed mods with their own MCM getting settings wiped on preset save
[*]Fixed content-only mods falsely flagged as incompatible
[*]Fixed re-enabled mods staying silently disabled
[*]Fixed self-test leaving ButterLib subsystems off
[*]Fixed scene-script registration for rescued mods
[*]Fixed game version/branch and loaded-module lookups returning nothing
[*]Fixed beta-branch tick crash guard not applying
[/list]
```

---

## 2. Nexus sticky post

```
1.0.6 - Bug fix update

Multiple bugs fixed in this update:

- The startup "dependency conflict" crash with mods built against newer UIExtenderEx (AI Influence 5.0.7 and similar) — fixed, the missing API is implemented now.
- Downloaded mods blocked by Windows ("mark of the web") causing that same dependency-conflict error — ModReady now sets the game config so they just load. No more right-click-unblock. Takes effect from the next launch after you update.
- Campaign saves made with the official BUTR modules (ButterLib/MCM) that froze when you loaded them under ModReady — fixed, your saves load fine now.
- Settings that wouldn't save — mods that ship their own MCM were getting their settings wiped when you saved a preset. Fixed.
- Dropdown settings that showed up as a checkbox and forgot your choice — now they render as a real dropdown and keep your selection.
- Group on/off toggles that had gone missing from the settings menu — the row is back, so you can turn a feature on/off again.
- Harmless content mods (texture/asset packs) getting falsely flagged as "incompatible" — fixed.
- A mod you re-enabled after an auto-disable not loading its code — fixed.
- The built-in self-test leaving ButterLib subsystems switched off after running — fixed.
- A couple of internal lookups (game version/branch, loaded-module list) that were returning nothing — fixed.

I may not answer every comment, but I do read them — and any bug I see, I'll fix.
```

---

## 3. Steam change note (plain text)

```
v1.0.6

- Fixed startup "dependency conflict" crash with mods using the newer UIExtenderEx insert API (AI Influence 5.0.7 etc.)
- Windows-blocked (mark-of-the-web) mod DLLs now load automatically - no more manual unblocking
- Fixed saves made with official BUTR modules freezing on load
- Fixed dropdown settings showing as checkboxes and losing your selection
- Fixed group on/off toggles missing from Mod Options
- Fixed mods with their own MCM getting settings wiped on preset save
- Fixed content-only mods falsely flagged as incompatible
- Fixed re-enabled mods staying silently disabled
- Fixed self-test leaving ButterLib subsystems off
- Fixed scene-script registration for rescued mods
- Fixed game version/branch and loaded-module lookups returning nothing
- Fixed beta-branch tick crash guard not applying
```

---

## 4. GitHub release (markdown)

Tag: `v1.0.6`  ·  Title: `v1.0.6 — dependency-conflict startup crashes fixed`
Compare: https://github.com/Trashpanda62/modready/compare/v1.0.5...v1.0.6

```markdown
## v1.0.6

- Fixed startup "dependency conflict" crash with mods using the newer UIExtenderEx insert API (AI Influence 5.0.7 etc.)
- Windows-blocked (mark-of-the-web) mod DLLs now load automatically - no more manual unblocking
- Fixed saves made with official BUTR modules freezing on load
- Fixed dropdown settings showing as checkboxes and losing your selection
- Fixed group on/off toggles missing from Mod Options
- Fixed mods with their own MCM getting settings wiped on preset save
- Fixed content-only mods falsely flagged as incompatible
- Fixed re-enabled mods staying silently disabled
- Fixed self-test leaving ButterLib subsystems off
- Fixed scene-script registration for rescued mods
- Fixed game version/branch and loaded-module lookups returning nothing
- Fixed beta-branch tick crash guard not applying

**Install:** extract the `Modules` folder into your Bannerlord install, enable Harmony / UIExtenderEx / ButterLib / MCM, Play.
```

---

## 5. Patreon draft

```
ModReady v1.0.6 is out. Headliner: the startup "dependency conflict" crash — both flavors of it. Mods built against newer UIExtenderEx (AI Influence 5.0.7 was the report) now load, and Windows-blocked downloads don't need the right-click-unblock dance anymore; ModReady fixes the game config itself. It also hunts down the settings-menu gremlins: dropdowns that showed up as checkboxes (and forgot your choice), group on/off toggles that had gone missing, and settings-heavy mods that got their config wiped when you saved a preset — all fixed. It also stops ModReady from crying "incompatible" at harmless texture/asset packs, and makes a re-enabled mod actually load again.

No install changes — same drop-in dependency stack, now just quieter and better-behaved. Grab it on Nexus: https://www.nexusmods.com/mountandblade2bannerlord/mods/11274 . Thanks as always for keeping this going.
```
