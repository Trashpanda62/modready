# ModReady v1.0.6 — release texts

Release zip: `C:\dev\modready\dist\ModReady-v1.0.6.zip` (deps-only, 4 BUTR modules, no BLSE).
Nexus mod 11274. Bug-fix release after v1.0.5.

---

## 1. Nexus changelog (BBCode — paste into the mod's Changes tab)

```bbcode
[b]v1.0.6 — mod settings behave again, and fewer false "incompatible" flags[/b]

[b]Fixed[/b]
[list]
[*]Campaign saves made with the upstream/official BUTR modules (ButterLib/MCM v5) that froze on load under ModReady now load correctly — ModReady registers the upstream save type-ids.
[*]Content-only mods (texture/asset packs with no code) are no longer wrongly reported as "incompatible" or written into the disable list and bug reports.
[*]A mod you re-enable after an auto-disable now loads its code again, instead of staying silently disabled for up to a week.
[*][b]Dropdown settings[/b] now render as a dropdown (not a checkbox) and keep your selection across launches — both fluent-built settings and older MCM-v1 dropdowns.
[*]A group's [b]master on/off toggle[/b] shows as a row in Mod Options again — you can turn a feature back on instead of it vanishing from the UI.
[*]Mods that ship their own MCM no longer get their settings overwritten with an empty file when you save a preset or capture a profile.
[*]The built-in self-test no longer leaves ButterLib subsystems switched off after it runs.
[*]Rescued mods register their scene-script types correctly, so their custom props/scenes resolve instead of silently going missing.
[*]Internal helpers other mods rely on return real data again (loaded-module list, and correct game version + branch detection).
[*]Beta-branch agent-tick crash guard is applied correctly again; the public branch is correctly unaffected.
[/list]
```

---

## 2. Nexus sticky post

```
1.0.6 - Bug fix update

Multiple bugs fixed in this update:

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

## 3. Steam change note (plain text, ≤150 words)

```
v1.0.6 — MCM settings fixes + fewer false incompatibility flags.

Fixed:
- Campaign saves made with the official BUTR modules that froze on load under ModReady now load correctly.
- Dropdown settings render as dropdowns (not checkboxes) and keep your selection across launches.
- A group's master on/off toggle shows as a row again.
- Mods with their own MCM no longer get their settings wiped on preset/profile save.
- Content-only mods (texture/asset packs) are no longer false-flagged "incompatible."
- A mod you re-enable after an auto-disable loads its code again.
- The self-test no longer leaves ButterLib subsystems off.
- Rescued mods register their scene-script types correctly.
- Internal version/branch and loaded-module lookups return real data again.

No install or load-order changes. Enable Harmony, UIExtenderEx, ButterLib and MCM and Play.
```

---

## 4. GitHub release (markdown)

Tag: `v1.0.6`  ·  Title: `v1.0.6 — mod settings behave again`
Compare: https://github.com/Trashpanda62/modready/compare/v1.0.5...v1.0.6

```markdown
## v1.0.6 — mod settings behave again, and fewer false "incompatible" flags

**Fixed**
- Campaign saves made with the upstream/official BUTR modules (ButterLib/MCM v5) that froze on load under ModReady now load correctly — ModReady registers the upstream save type-ids.
- Content-only mods (texture/asset packs with no code) are no longer wrongly reported as "incompatible" or written into the disable list and bug reports.
- A mod you re-enable after an auto-disable now loads its code again, instead of staying silently disabled for up to a week.
- Dropdown settings now render as a dropdown (not a checkbox) and keep your selection across launches — both fluent-built settings and older MCM-v1 dropdowns.
- A group's master on/off toggle shows as a row in Mod Options again.
- Mods that ship their own MCM no longer get their settings overwritten with an empty file on preset/profile save.
- The built-in self-test no longer leaves ButterLib subsystems switched off after it runs.
- Rescued mods register their scene-script types correctly, so their custom props/scenes resolve.
- Internal helpers other mods rely on return real data again (loaded-module list, correct game version + branch detection).
- Beta-branch agent-tick crash guard is applied correctly again; the public branch is correctly unaffected.

**Install:** extract the `Modules` folder into your Bannerlord install (the one with `bin` and `Modules`), enable Harmony / UIExtenderEx / ButterLib / MCM, then Play — native launcher or BLSE (optional). Deps-only; no BLSE bundled.
```

---

## 5. Patreon draft

```
ModReady v1.0.6 is out. This one hunts down the settings-menu gremlins: dropdowns that showed up as checkboxes (and forgot your choice), group on/off toggles that had gone missing, and settings-heavy mods that got their config wiped when you saved a preset — all fixed. It also stops ModReady from crying "incompatible" at harmless texture/asset packs, and makes a re-enabled mod actually load again.

No install changes — same drop-in dependency stack, now just quieter and better-behaved. Grab it on Nexus: https://www.nexusmods.com/mountandblade2bannerlord/mods/11274 . Thanks as always for keeping this going.
```
