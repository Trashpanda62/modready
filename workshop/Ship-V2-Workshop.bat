@echo off
REM ===========================================================================
REM  ModReady v2.0.0 -- Steam Workshop ship.
REM
REM  1-4: update ModReady's four old dependency items (Harmony, UIExtenderEx,
REM       ButterLib, MCM) to the "RETIRED - unsubscribe" notice module.
REM  5:   create the new single ModReady add-on item.
REM
REM  Prereqs: Steam running and logged in; framework\scripts\Build-V2.ps1 run
REM  (stages framework\dist\v2\). Regenerate the XMLs with
REM  make-v2-workshop-xml.py if any text changed.
REM
REM  If a window keeps printing "Status: k_EItemUpdateStatusInvalid 0/0", the
REM  upload already succeeded -- CLOSE that window and the next item starts.
REM ===========================================================================

set "UPLOADER=TaleWorlds.MountAndBlade.SteamWorkshop.exe"
set "WS=C:\dev\modready\workshop"
cd /d "C:\Program Files (x86)\Steam\steamapps\common\Mount & Blade II Bannerlord\bin\Win64_Shipping_Client"

echo [1/5] Retire ModReady - Harmony...
start "Retire Harmony"      /wait "%UPLOADER%" "%WS%\WorkshopRetire-Harmony.xml"
echo [2/5] Retire ModReady - UIExtenderEx...
start "Retire UIExtenderEx" /wait "%UPLOADER%" "%WS%\WorkshopRetire-UIExtenderEx.xml"
echo [3/5] Retire ModReady - ButterLib...
start "Retire ButterLib"    /wait "%UPLOADER%" "%WS%\WorkshopRetire-ButterLib.xml"
echo [4/5] Retire ModReady - MCM...
start "Retire MCM"          /wait "%UPLOADER%" "%WS%\WorkshopRetire-MCM.xml"
echo [5/5] Create ModReady v2 item...
start "Create ModReady"     /wait "%UPLOADER%" "%WS%\WorkshopCreate-ModReady.xml"

echo Done. Add BUTR Harmony (2859188632) as a Required Item on the new ModReady item page.
pause
