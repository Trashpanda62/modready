@echo off
REM ===========================================================================
REM  UPDATE the four EXISTING ModReady Steam Workshop items (Harmony,
REM  UIExtenderEx, ButterLib, MCM) to the current payload + change-notes.
REM
REM  Use this for every release AFTER the first. (UploadToWorkshop-ModReady.bat
REM  is the one-time CREATE script that mints new item IDs.)
REM
REM  Double-click from File Explorer (NOT a terminal) so Steam can inject its
REM  API. Steam MUST be running and logged in.
REM
REM  Prereqs:
REM    1. Build the payload first:  C:\dev\modready\scripts\sync-payload.ps1
REM    2. Each workshop\WorkshopUpdate-*.xml already has the correct <ItemId>,
REM       <ModuleFolder> (-> installer\payload\Modules\...), <ChangeNotes> and
REM       game-version <Tag>. Bump the <Tag> if the Bannerlord version changed.
REM
REM  If a window keeps printing "Status: k_EItemUpdateStatusInvalid 0/0", the
REM  upload already succeeded -- CLOSE that window and the next item starts.
REM ===========================================================================

set "UPLOADER=TaleWorlds.MountAndBlade.SteamWorkshop.exe"
set "WS=C:\dev\modready\workshop"
cd /d "C:\Program Files (x86)\Steam\steamapps\common\Mount & Blade II Bannerlord\bin\Win64_Shipping_Client"

echo [1/4] ModReady - Harmony...
start "ModReady Harmony"      /wait "%UPLOADER%" "%WS%\WorkshopUpdate-Harmony.xml"

echo [2/4] ModReady - UIExtenderEx...
start "ModReady UIExtenderEx" /wait "%UPLOADER%" "%WS%\WorkshopUpdate-UIExtenderEx.xml"

echo [3/4] ModReady - ButterLib...
start "ModReady ButterLib"    /wait "%UPLOADER%" "%WS%\WorkshopUpdate-ButterLib.xml"

echo [4/4] ModReady - MCM...
start "ModReady MCM"          /wait "%UPLOADER%" "%WS%\WorkshopUpdate-MCM.xml"

echo.
echo All four update windows have been launched and closed.
echo If any showed "k_EItemUpdateStatusInvalid 0/0", that item still succeeded.
pause
