<#
  Build-Installer.ps1 -- compile the ModReady one-click installer.

  ModReady is self-contained: the bundled BLSE binaries + four BUTR dependency
  modules live in installer\payload\ (a vendored snapshot). This script just
  validates that payload and compiles installer\ModReady.iss with Inno Setup
  into dist\ModReady-v<ver>.exe. It does NOT depend on the beta-deps repo.

  To refresh the bundled modules/BLSE after a new beta-deps build, run
  scripts\sync-payload.ps1 first.

  Prerequisite (one-time):
    - Inno Setup 6 (https://jrsoftware.org/isdl.php) -- provides ISCC.exe.
      (winget install JRSoftware.InnoSetup puts it under
       %LOCALAPPDATA%\Programs\Inno Setup 6.)

  Usage:
    cd C:\dev\modready
    .\scripts\Build-Installer.ps1 -Version 1.0.0
#>

param(
  [string] $Version = '1.0.0'
)

$ErrorActionPreference = 'Stop'
$Repo      = Split-Path $PSScriptRoot -Parent
$Installer = Join-Path $Repo 'installer'
$Payload   = Join-Path $Installer 'payload'
$Dist      = Join-Path $Repo 'dist'

function Fail($msg) { Write-Host "ERROR: $msg" -ForegroundColor Red; exit 1 }

# --- 1. sanity: vendored payload present -------------------------------------
$deps = 'Bannerlord.Harmony','Bannerlord.UIExtenderEx','Bannerlord.ButterLib','Bannerlord.MBOptionScreen'
$payloadModules = Join-Path $Payload 'Modules'
if (-not (Test-Path $payloadModules)) {
  Fail "payload\Modules not found. Run .\scripts\sync-payload.ps1 to vendor the dependency modules + BLSE."
}
foreach ($m in $deps) {
  $dll = Join-Path $payloadModules "$m\bin\Win64_Shipping_Client\BetaDeps.Foundation.dll"
  if (-not (Test-Path (Join-Path $payloadModules $m))) { Fail "payload\Modules\$m is missing -- run sync-payload.ps1." }
  if (-not (Test-Path $dll)) { Fail "payload\Modules\$m is missing BetaDeps.Foundation.dll (required shim) -- run sync-payload.ps1." }
}
# Guard against accidentally vendoring the BetaDeps framework module.
if (Test-Path (Join-Path $payloadModules 'BetaDeps')) {
  Fail "payload\Modules\BetaDeps must NOT be present -- ModReady ships the dependency stack only. Re-run sync-payload.ps1 (it excludes BetaDeps)."
}
$blseLauncher = Join-Path $Payload 'BLSE\Bannerlord.BLSE.LauncherEx.exe'
if (-not (Test-Path $blseLauncher)) { Fail "payload\BLSE\Bannerlord.BLSE.LauncherEx.exe missing -- run sync-payload.ps1." }
foreach ($lic in 'BLSE-LICENSE.txt','BetaDeps-THIRD-PARTY-LICENSES.txt') {
  if (-not (Test-Path (Join-Path $Payload "LICENSES\$lic"))) { Fail "payload\LICENSES\$lic missing (required notice) -- run sync-payload.ps1." }
}

# --- 2. find ISCC ------------------------------------------------------------
$iscc = Get-Command ISCC.exe -ErrorAction SilentlyContinue
if ($iscc) {
  $iscc = $iscc.Source
} else {
  foreach ($c in @(
    "${env:ProgramFiles(x86)}\Inno Setup 6\ISCC.exe",
    "$env:ProgramFiles\Inno Setup 6\ISCC.exe",
    "$env:LOCALAPPDATA\Programs\Inno Setup 6\ISCC.exe")) {
    if (Test-Path $c) { $iscc = $c; break }
  }
}
if (-not $iscc) {
  Fail 'Inno Setup (ISCC.exe) not found. Install Inno Setup 6 from https://jrsoftware.org/isdl.php and re-run.'
}

# --- 3. compile --------------------------------------------------------------
if (-not (Test-Path $Dist)) { New-Item -ItemType Directory -Path $Dist | Out-Null }
Write-Host 'Compiling ModReady installer with Inno Setup...' -ForegroundColor Cyan
& $iscc "/DAppVersion=$Version" (Join-Path $Installer 'ModReady.iss')
if ($LASTEXITCODE -ne 0) { Fail "Inno Setup compile failed (exit $LASTEXITCODE)." }

Write-Host "Done. Installer written to dist\ModReady-v$Version.exe" -ForegroundColor Green
