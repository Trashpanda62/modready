@echo off
REM ===========================================================================
REM  Create the FOUR ModReady Steam Workshop items (Harmony, UIExtenderEx,
REM  ButterLib, MCM) from the current ModReady payload.
REM
REM  Double-click this from File Explorer (NOT a terminal) so Steam can inject
REM  its API into the uploader. Steam MUST be running and logged in, and you
REM  must have accepted the Workshop legal agreement once (it pops on first run).
REM
REM  Prereqs:
REM    1. Build the payload first:  C:\dev\modready\scripts\sync-payload.ps1
REM    2. The TaleWorlds uploader must exist at the path below (adjust if your
REM       Steam library is on another drive).
REM
REM  Each CreateItem prints a new Workshop ItemId in its window. WRITE IT DOWN
REM  for each module, then paste it into the matching workshop\WorkshopUpdate-*.xml
REM  <ItemId> field so future updates target the right item.
REM
REM  If a window keeps printing "Status: k_EItemUpdateStatusInvalid 0/0", the
REM  upload already succeeded -- CLOSE that window and the next item starts.
REM ===========================================================================

set "UPLOADER=TaleWorlds.MountAndBlade.SteamWorkshop.exe"
set "WS=C:\dev\modready\workshop"
cd /d "C:\Program Files (x86)\Steam\steamapps\common\Mount & Blade II Bannerlord\bin\Win64_Shipping_Client"

echo [1/4] ModReady - Harmony...
start "ModReady Harmony"      /wait "%UPLOADER%" "%WS%\WorkshopCreate-Harmony.xml"

echo [2/4] ModReady - UIExtenderEx...
start "ModReady UIExtenderEx" /wait "%UPLOADER%" "%WS%\WorkshopCreate-UIExtenderEx.xml"

echo [3/4] ModReady - ButterLib...
start "ModReady ButterLib"    /wait "%UPLOADER%" "%WS%\WorkshopCreate-ButterLib.xml"

echo [4/4] ModReady - MCM...
start "ModReady MCM"          /wait "%UPLOADER%" "%WS%\WorkshopCreate-MCM.xml"

echo.
echo All four create windows have been launched and closed.
echo Now: note each item's ItemId, paste them into workshop\WorkshopUpdate-*.xml,
echo make a "ModReady" Collection from the four items, and (see STEAM-WORKSHOP.md)
echo hide the old standalone "BetaDeps - X" dependency items.
pause
