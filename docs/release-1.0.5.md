# ModReady 1.0.5 — release texts

## Nexus FILE description (Main File ZIP) — 254 chars (limit 255)

Harmony, UIExtenderEx, ButterLib and MCM in one install - the dependency stack most Bannerlord mods need. Steam and Game Pass supported. Extract the Modules folder into your Bannerlord folder, merge, enable, play. Clean-room ModReady builds; credit BUTR.

## Changes since 1.0.0 (consolidated, user-facing)

**Game Pass / Microsoft Store**
- Fixed the startup crash that blocked launch on Game Pass (1.0.2, 1.0.3).
- Removed the harmless "could not be loaded correctly due to a dependency conflict" pop-up at startup — a .NET-Core-only quirk in how the native launcher preloads bundled DLLs; the modules always loaded correctly (1.0.5). Steam was never affected.

**MCM (Mod Configuration Menu)**
- Fixed the "dependency conflict" error on startup (1.0.1).
- Mods built against the real BUTR MCM now show and save their settings (was a blank panel) (1.0.4).
- Added a "Sub Systems" page to enable/disable ButterLib subsystems, saved across restarts (1.0.4).
- Setting buttons now show the setting's name instead of a generic "Run" (1.0.4).
- MCM now uses installed language packs instead of always showing English (1.0.2, 1.0.4).

**UIExtenderEx**
- Buttons and text boxes from other mods now appear on the game's built-in screens again (1.0.2).
- Fixed mods that add controls to 1.2+ code-generated screens (e.g. Clan Control's clan-screen buttons) (1.0.4).

**Load order / packaging**
- The four dependency modules now pin above the native modules in the launch order, like real BUTR (1.0.4).
- Bundled DLLs listed in dependency order; dropped an unused System.ValueTuple.dll from the Harmony Game Pass build (1.0.5).

## Per-version (matches CHANGELOG.md)

- **1.0.5** — Game Pass dependency-conflict pop-up silenced; dependency-ordered DLL lists; ValueTuple cleanup.
- **1.0.4** — Real-BUTR MCM settings show/save; deps pin above native; Sub Systems page; 1.2+ generated-screen UI fix; MCM button labels; MCM localization.
- **1.0.3** — Game Pass launch crash fully resolved.
- **1.0.2** — Game Pass launch crash fix; foreign-mod controls on built-in screens; MCM localization.
- **1.0.1** — MCM "dependency conflict" startup error fixed.
- **1.0.0** — First release: Harmony, UIExtenderEx, ButterLib, MCM in one manual-install zip.
