# ModReady v1.0.6 — release texts

Release zip: `C:\dev\modready\dist\ModReady-v1.0.6.zip` (deps-only, 4 BUTR modules, no BLSE).
Nexus mod 11274. Bug-fix release after v1.0.5.

---

## 1. Nexus changelog (BBCode — paste into the mod's Changes tab)

```bbcode
[b]v1.0.6 — mod settings behave again, and fewer false "incompatible" flags[/b]

[b]Fixed[/b]
[list]
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
v1.0.6 is up. This one's all about MCM: your mod settings actually behave now — dropdowns show as dropdowns and keep your pick across launches, a group's master on/off toggle is back as a row, and settings-heavy mods that ship their own MCM stop getting their config wiped when you save a preset. On top of that, ModReady stops false-flagging harmless content-only mods (texture/asset packs) as "incompatible," and a mod you re-enable after an auto-disable actually loads again.

No load-order or install changes — enable Harmony, UIExtenderEx, ButterLib and MCM (the game auto-sorts them) and Play, through the native launcher or BLSE if you use it. If your settings pages were misbehaving on an earlier build, grab this update.

Problem? Post it on the Bugs tab with your Modules\Bannerlord.Harmony\runtime.log attached.
```

---

## 3. Steam change note (plain text, ≤150 words)

```
v1.0.6 — MCM settings fixes + fewer false incompatibility flags.

Fixed:
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
