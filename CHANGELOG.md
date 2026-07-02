# ModReady changelog

## v1.0.6 — 2026-07-02

- Campaign saves made with the upstream/official BUTR modules (ButterLib/MCM v5) that froze on load under ModReady now load correctly — ModReady registers the upstream save type-ids.
- Content-only mods (texture/asset packs with no code) are no longer wrongly reported as "incompatible" or written into the disable list and bug reports.
- A mod you re-enable in the launcher after an auto-disable now loads its code again, instead of staying silently disabled for up to a week.
- Rescued mods now register their scene-script types correctly, so their custom props/scenes resolve instead of silently going missing.
- Dropdown settings now render as a dropdown (not a checkbox) and keep your selection across launches — this affected both fluent-built settings and older MCM-v1 dropdowns.
- A group's master on/off toggle now appears as a row in Mod Options again — you can turn a feature back on instead of it vanishing from the UI.
- Settings for mods that ship their own MCM are no longer overwritten with an empty file when you save a preset or capture a profile.
- The built-in self-test no longer leaves ButterLib subsystems switched off after it runs.
- Internal helpers other mods rely on now return real data instead of always empty/null (loaded-module list, and correct game version + branch detection).
- Beta-branch agent-tick crash guard is applied correctly again (the signature check counted the wrong number of parameters); the public branch is correctly unaffected.

## v1.0.5 — 2026-06-28

- Silenced the harmless "could not be loaded correctly due to a dependency conflict" pop-up on Game Pass / Microsoft Store at startup. It was a .NET-Core-only quirk in how the native launcher preloads bundled dependency DLLs (it probes them by bare filename and can't find them, but the modules load correctly anyway); the warning never affected the mod. Steam was never affected.
- Listed each module's bundled DLLs in dependency order and dropped an unused System.ValueTuple.dll from the Harmony Game Pass build (cleanup).

## v1.0.4 — 2026-06-27

- Mods built against the real BUTR MCM now show and save their settings (were showing a blank panel).
- The four dependency modules now pin above the native modules in the launch order, like real BUTR, instead of scattering mid-list.
- Added a "Sub Systems" page to enable/disable ButterLib subsystems, saved across restarts.
- Fixed UIExtenderEx mods that add controls to 1.2+ code-generated screens (e.g. Clan Control's clan-screen buttons) — their additions appear again.
- MCM buttons now show the setting's name instead of a generic "Run".
- MCM now uses installed language packs instead of always showing English.

## v1.0.3 — 2026-06-23

- Fixed the Game Pass / Microsoft Store launch crash that v1.0.2 did not fully resolve.

## v1.0.2 — 2026-06-20

- Fixed Game Pass / Microsoft Store launch crash.
- Fixed buttons and text boxes from other mods not appearing on built-in game screens.
- Fixed MCM not using installed language packs (was always showing English).

## v1.0.1 — 2026-06-19

- Fixed MCM "dependency conflict" error on startup.

## v1.0.0 — 2026-06-19

- First release: Harmony, UIExtenderEx, ButterLib, and MCM in one manual-install zip (requires BLSE).
