# ModReady — Steam Workshop publishing guide

The actual upload runs on your machine (it needs your Steam login + the one-time
Workshop legal agreement), so the steps below are copy-paste ready.

## Structure (decided 2026-06-19)

Bannerlord's Workshop uploader takes **one module folder per item**, and ModReady
is four modules — so it's four items + a Collection, the same shape as BetaDeps.

| Workshop item | Module folder |
|---|---|
| ModReady — Harmony | `Bannerlord.Harmony` |
| ModReady — UIExtenderEx | `Bannerlord.UIExtenderEx` |
| ModReady — ButterLib | `Bannerlord.ButterLib` |
| ModReady — MCM | `Bannerlord.MBOptionScreen` |

These four module **IDs are identical** to your existing standalone
`BetaDeps — Harmony/UIExtenderEx/ButterLib/MCM` Workshop items. Two Workshop
items publishing the same module ID = a duplicate-module conflict for anyone
subscribed to both. **The plan is to make ModReady's the canonical dependency
items and retire the old BetaDeps ones** (see step 4). Keep the **BetaDeps main
module** item — only the four BetaDeps *dependency* items get retired.

## One-time prep

1. **Enable Steam Cloud for Bannerlord** (required or the upload fails):
   Steam Library → right-click *Mount & Blade II: Bannerlord* → Properties →
   General → tick **Keep game saves in the Steam Cloud**.
2. Build the payload so the module folders are current and carry the v1.0.1 fix:
   ```powershell
   cd C:\dev\modready
   .\scripts\sync-payload.ps1
   ```
3. Preview image: `workshop\ModReady-Image.png` (838 KB, under Steam's 1 MB cap).
   All four create XMLs already point at it.

## Tags (all four items)

Type **Utility** · Setting **Native** · Game Mode **Singleplayer**
(MCM also adds **Multiplayer**) · Compatible Version **v1.4.6**.
Confirm the version-tag string against the Workshop "Browse by Tag" list when you
upload — if it shows as `e1.4.6`, change the `<Tag Value="v1.4.6" />` lines.

## Step 1 — create the four items

Double-click **`workshop\UploadToWorkshop-ModReady.bat`** from File Explorer (NOT
a terminal), or run each manually from `…\bin\Win64_Shipping_Client`:

```
TaleWorlds.MountAndBlade.SteamWorkshop.exe "C:\dev\modready\workshop\WorkshopCreate-Harmony.xml"
TaleWorlds.MountAndBlade.SteamWorkshop.exe "C:\dev\modready\workshop\WorkshopCreate-UIExtenderEx.xml"
TaleWorlds.MountAndBlade.SteamWorkshop.exe "C:\dev\modready\workshop\WorkshopCreate-ButterLib.xml"
TaleWorlds.MountAndBlade.SteamWorkshop.exe "C:\dev\modready\workshop\WorkshopCreate-MCM.xml"
```

First run pops the Workshop legal agreement — accept it. An endless
`Status: k_EItemUpdateStatusInvalid 0/0` usually means it already succeeded:
close the window and check the Workshop page.

## Step 2 — record the item IDs

Each create prints a new **ItemId**. Paste each into the matching
`workshop\WorkshopUpdate-<module>.xml` `<ItemId>` field (they're stubbed
`PASTE_ITEM_ID_AFTER_CREATE`) so later updates target the right item.

## Step 3 — make the Collection

Steam → your Workshop profile → Create Collection → add all four ModReady items →
name it **"ModReady — Bannerlord Dependencies"** → set Public. Tell users to
subscribe to the Collection so they get all four. Cross-link the Collection URL
on the [Nexus page](https://www.nexusmods.com/mountandblade2bannerlord) and put
your Nexus/GitHub links in the Steam descriptions.

## Step 4 — retire the old BetaDeps dependency items

For each of the four old items below, open its Workshop page → Edit → set
**Visibility = Hidden** (hiding stops new subscriptions; existing subscribers are
unaffected). **Leave the BetaDeps main item Public.**

| Old item | ID |
|---|---|
| BetaDeps — Harmony | 3741428196 |
| BetaDeps — UIExtenderEx | 3741428357 |
| BetaDeps — ButterLib | 3741428541 |
| BetaDeps — MCM | 3741428715 |

**Heads-up:** those four items are also in your existing "BetaDeps (Early
Dependencies)" Collection. After hiding them, edit that Collection to point at
the four **ModReady** dependency items instead (same DLLs) so the BetaDeps
Collection still resolves for new users. One canonical set of dependency items,
no duplicate module IDs.

## Updating later (new ModReady version)

Once the `<ItemId>` fields are filled in, bump `<ChangeNotes>` in each
`workshop\WorkshopUpdate-*.xml` and run from `…\bin\Win64_Shipping_Client`:

```
TaleWorlds.MountAndBlade.SteamWorkshop.exe "C:\dev\modready\workshop\WorkshopUpdate-Harmony.xml"
TaleWorlds.MountAndBlade.SteamWorkshop.exe "C:\dev\modready\workshop\WorkshopUpdate-UIExtenderEx.xml"
TaleWorlds.MountAndBlade.SteamWorkshop.exe "C:\dev\modready\workshop\WorkshopUpdate-ButterLib.xml"
TaleWorlds.MountAndBlade.SteamWorkshop.exe "C:\dev\modready\workshop\WorkshopUpdate-MCM.xml"
```

## Licensing / credit

Bundled dependency DLLs are MIT (0Harmony, Mono.Cecil, MonoMod.*, Newtonsoft.Json);
notices ship in each module. The BUTR dependency stack is the work of **BUTR**
(https://github.com/BUTR) — credit them on every item page.
