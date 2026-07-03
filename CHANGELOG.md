# ModReady changelog

## v1.0.6 — 2026-07-02

- Fixed the main-menu "Continue" save-load loop with mismatched modules (load from the Saved Games list was unaffected)
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
