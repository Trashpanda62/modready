<#
  Build-Zip.ps1 -- produce the manual-install ModReady zip.

  Why a zip as well as the installer .exe: Nexus's automated malware scanner is
  sensitive to Inno Setup self-extracting .exe installers and may flag them as
  unsafe. A plain zip of the module files + BLSE is the conventional Nexus format
  and sidesteps that -- the user extracts it into their Bannerlord folder.

  Builds dist\ModReady-v<ver>.zip from the vendored installer\payload\, laid out
  so the user drag-extracts it into the Bannerlord ROOT:

    bin\Win64_Shipping_Client\   <- BLSE binaries
    Modules\Bannerlord.Harmony\        (+ the other 3 dependency modules)
    licenses\                    <- BLSE MIT + third-party notices
    README.txt                   <- install instructions

  Zip entry names use forward slashes so native Linux/Steam Deck extractors
  (unzip, 7z, ark, file-roller) produce a correct nested tree.

  Usage:
    cd C:\dev\modready
    .\scripts\Build-Zip.ps1 -Version 1.0.0
#>

param(
  [string] $Version = '1.0.0'
)

$ErrorActionPreference = 'Stop'
$Repo    = Split-Path $PSScriptRoot -Parent
$Payload = Join-Path $Repo 'installer\payload'
$Dist    = Join-Path $Repo 'dist'

function Fail($msg) { Write-Host "ERROR: $msg" -ForegroundColor Red; exit 1 }

$deps = 'Bannerlord.Harmony','Bannerlord.UIExtenderEx','Bannerlord.ButterLib','Bannerlord.MBOptionScreen'
$payloadModules = Join-Path $Payload 'Modules'
$payloadBlse    = Join-Path $Payload 'BLSE'
$payloadLic     = Join-Path $Payload 'LICENSES'

# --- sanity: payload present -------------------------------------------------
if (-not (Test-Path $payloadModules)) { Fail "payload\Modules not found. Run .\scripts\sync-payload.ps1 first." }
foreach ($m in $deps) {
  if (-not (Test-Path (Join-Path $payloadModules $m))) { Fail "payload\Modules\$m missing -- run sync-payload.ps1." }
}
if (Test-Path (Join-Path $payloadModules 'BetaDeps')) { Fail "payload\Modules\BetaDeps must NOT be present -- ModReady is the dependency stack only." }
if (-not (Test-Path (Join-Path $payloadBlse 'Bannerlord.BLSE.LauncherEx.exe'))) { Fail "payload\BLSE missing LauncherEx -- run sync-payload.ps1." }

# --- assemble a staging tree shaped like the Bannerlord root -----------------
$Stage = Join-Path $Dist ("_zipstage_v$Version")
if (Test-Path $Stage) { Remove-Item $Stage -Recurse -Force }
New-Item -ItemType Directory -Path $Stage | Out-Null

# BLSE -> bin\Win64_Shipping_Client\
$stageBin = Join-Path $Stage 'bin\Win64_Shipping_Client'
New-Item -ItemType Directory -Path $stageBin | Out-Null
Copy-Item (Join-Path $payloadBlse '*') $stageBin -Recurse -Force

# 4 dependency modules -> Modules\
$stageModules = Join-Path $Stage 'Modules'
New-Item -ItemType Directory -Path $stageModules | Out-Null
foreach ($m in $deps) { Copy-Item (Join-Path $payloadModules $m) $stageModules -Recurse -Force }

# licenses -> licenses\
$stageLic = Join-Path $Stage 'licenses'
New-Item -ItemType Directory -Path $stageLic | Out-Null
if (Test-Path $payloadLic) { Copy-Item (Join-Path $payloadLic '*') $stageLic -Recurse -Force }

# README.txt
$readme = @"
ModReady v$Version  -  manual install
=====================================

Gets a fresh Mount & Blade II: Bannerlord install mod-ready: BLSE + the four
BUTR dependency modules (Harmony, UIExtenderEx, ButterLib, MCM).

INSTALL
  1. Open your Bannerlord install folder -- the one containing the "bin" and
     "Modules" folders. Typically:
       C:\Program Files (x86)\Steam\steamapps\common\Mount & Blade II Bannerlord
  2. Extract this zip's "bin" and "Modules" folders into that folder, MERGING
     when Windows asks (this adds files; it does not overwrite the game).
  3. Launch the game through BLSE:
       bin\Win64_Shipping_Client\Bannerlord.BLSE.LauncherEx.exe
     (make a desktop shortcut to it if you like).
  4. In the launcher, enable Harmony, ButterLib, UIExtenderEx and MCM (and any
     content mods you add later), then Play.

That's it -- you're mod-ready. Add the content mods you want into Modules\.

CREDITS
  BLSE and the BUTR dependency stack are by BUTR (https://github.com/BUTR),
  bundled with permission. The four dependency modules are clean-room BetaDeps
  builds. License notices are in the licenses\ folder.
"@
Set-Content -Path (Join-Path $Stage 'README.txt') -Value $readme -Encoding UTF8

# --- write the zip with forward-slash entries (Linux/Deck-safe) --------------
if (-not (Test-Path $Dist)) { New-Item -ItemType Directory -Path $Dist | Out-Null }
$ZipPath = Join-Path $Dist ("ModReady-v$Version.zip")
if (Test-Path $ZipPath) { Remove-Item $ZipPath -Force }

Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
$zipFs = [System.IO.File]::Open($ZipPath, [System.IO.FileMode]::Create)
try {
  $archive = New-Object System.IO.Compression.ZipArchive($zipFs, [System.IO.Compression.ZipArchiveMode]::Create)
  try {
    $prefixLen = $Stage.Length + 1
    Get-ChildItem -Path $Stage -Recurse -File | ForEach-Object {
      $rel = $_.FullName.Substring($prefixLen).Replace('\','/')
      [System.IO.Compression.ZipFileExtensions]::CreateEntryFromFile(
        $archive, $_.FullName, $rel, [System.IO.Compression.CompressionLevel]::Optimal) | Out-Null
    }
  } finally { $archive.Dispose() }
} finally { $zipFs.Dispose() }

Remove-Item $Stage -Recurse -Force
$mb = [math]::Round((Get-Item $ZipPath).Length / 1MB, 2)
Write-Host "Done. dist\ModReady-v$Version.zip ($mb MB, manual-install layout, forward-slash entries)" -ForegroundColor Green
