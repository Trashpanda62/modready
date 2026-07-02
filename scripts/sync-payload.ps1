<#
  sync-payload.ps1 -- refresh ModReady's vendored payload from a modready build.

  ModReady is DEPS-ONLY: it bundles a SNAPSHOT of the four BUTR dependency modules
  (Bannerlord.Harmony/UIExtenderEx/ButterLib/MBOptionScreen) in installer\payload\.
  It does NOT bundle BLSE -- re-hosting BLSE's executables gets the download flagged
  by Nexus, so BLSE is a required separate mod. This script re-copies the four
  modules + the third-party license notices from a built modready repo. It
  deliberately EXCLUDES both the ModReady framework module and BLSE.

  Prerequisite: run <ModReadyRepo>\scripts\Build-Phase1.ps1 first so dist\Modules
  is fresh.

  Usage:
    cd C:\dev\modready
    .\scripts\sync-payload.ps1
    .\scripts\sync-payload.ps1 -ModReadyRepo C:\dev\modready\framework
#>

param(
  [string] $ModReadyRepo = 'C:\dev\modready\framework'
)

$ErrorActionPreference = 'Stop'
$Repo    = Split-Path $PSScriptRoot -Parent
$Payload = Join-Path $Repo 'installer\payload'

function Fail($msg) { Write-Host "ERROR: $msg" -ForegroundColor Red; exit 1 }

$deps = 'Bannerlord.Harmony','Bannerlord.UIExtenderEx','Bannerlord.ButterLib','Bannerlord.MBOptionScreen'

# --- resolve source ----------------------------------------------------------
$srcModules = Join-Path $ModReadyRepo 'dist\Modules'
if (-not (Test-Path $srcModules)) {
  Fail "modready dist\Modules not found at '$srcModules'. Run '$ModReadyRepo\scripts\Build-Phase1.ps1' first."
}

# --- rebuild payload\Modules (4 deps only) -----------------------------------
$payloadModules = Join-Path $Payload 'Modules'
if (Test-Path $payloadModules) { Remove-Item $payloadModules -Recurse -Force }
New-Item -ItemType Directory -Path $payloadModules -Force | Out-Null
foreach ($m in $deps) {
  $src = Join-Path $srcModules $m
  if (-not (Test-Path $src)) { Fail "dist\Modules\$m missing in modready -- rebuild it (Build-Phase1.ps1)." }
  Copy-Item $src $payloadModules -Recurse -Force
  Write-Host "  vendored Modules\$m" -ForegroundColor Cyan
}

# --- license notices (third-party MIT only; no BLSE license -- BLSE not shipped) ---
$payloadLic = Join-Path $Payload 'LICENSES'
if (Test-Path $payloadLic) { Remove-Item $payloadLic -Recurse -Force }
New-Item -ItemType Directory -Path $payloadLic -Force | Out-Null
$tpl = Join-Path $srcModules 'ModReady\THIRD-PARTY-LICENSES.txt'
if (-not (Test-Path $tpl)) {
  Fail "Third-party notices not found at '$tpl'. They are REQUIRED (Harmony/Cecil/MonoMod/Newtonsoft ship inside the deps). Run Build-Phase1.ps1."
}
Copy-Item $tpl (Join-Path $payloadLic 'ModReady-THIRD-PARTY-LICENSES.txt') -Force
Write-Host "  vendored third-party license notices" -ForegroundColor Cyan

# --- drop any stale BLSE payload from a previous (bundled) build --------------
$payloadBlse = Join-Path $Payload 'BLSE'
if (Test-Path $payloadBlse) { Remove-Item $payloadBlse -Recurse -Force; Write-Host "  removed stale payload\BLSE (no longer bundled)" -ForegroundColor DarkYellow }

# --- guards ------------------------------------------------------------------
if (Test-Path (Join-Path $payloadModules 'ModReady')) {
  Fail "payload\Modules\ModReady was vendored by mistake -- ModReady ships the dependency stack only."
}

Write-Host "Payload synced: 4 dependency modules (no BLSE, no ModReady module)." -ForegroundColor Green
