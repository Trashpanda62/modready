# ModReady changelog

## v1.1.0 — 2026-07-09

Compatible with Bannerlord 1.4.0 – 1.4.7. Steam and Game Pass.

- Fixed silent save-load hangs/crashes caused by a mod leaving a broken troop in a party (e.g. an orphaned WarbandForge/Retinues retinue): ModReady now removes leftover troops with no character/culture on load, so the map and party screens stop freezing
- Guarded the game's tooltip text lookup so a mod querying campaign UI text too early can't poison the map screen (the CampaignUIHelper "type initializer" crash) — this alone was hanging some save loads
- Guarded the map bar's player-info refresh so broken party data can't hang the campaign map on load
- Crash logs now show the full inner-exception chain, so the actual culprit mod is named instead of a generic wrapper
- Rolls up the Game Pass release: Steam-only mods (AI Influence, RBM, Retinues, etc.) now load on Game Pass / Microsoft Store, with no startup pop-ups, audio static, or crash

## v1.0.8 — 2026-07-05

- Game Pass: Steam-only mods (Win64-only build) now load — ModReady bridges their build to the Game Pass runtime at startup. Fixes AI Influence 5.0.7 (and similar) failing with "dependency conflict" / failing to construct on Game Pass while working on Steam
- Game Pass: the dependency shims that recover a mod's load failure (Harmony type-load recovery + assembly redirect) now run on the .NET 6 Game Pass runtime, not just Steam
- Game Pass: fixed loading-screen audio static introduced when bridging a Steam mod (no longer copies the mod's .NET Framework buffer/memory DLLs onto the .NET 6 runtime)
- Game Pass: fixed a startup crash from bridging ModReady's own umbrella module
- Game Pass: silenced the two "cannot find/load ModReady" startup pop-ups — the ModReady module now loads cleanly and no-ops on Game Pass (its extras run on Steam; the four dependency modules do the work on Game Pass)

## v1.0.7 — 2026-07-03

- Fixed saves failing to load when a mod ships multiple per-game-version DLLs in one folder (e.g. Diplomacy's 1.3.4–1.3.13) — only the active version now loads, instead of every sibling registering the same save type and corrupting the save system
- Added a boot-time warning to runtime.log when two loaded assemblies would register duplicate save types, so this class of save-load failure surfaces loudly instead of silently

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
