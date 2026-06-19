<#
  Build-Zip.ps1 -- produce the manual-install ModReady zip (deps-only).

  ModReady does NOT bundle BLSE. Nexus's malware scanner flags any archive that
  contains executables (BLSE ships three .exe files), so re-hosting BLSE inside
  the download gets the file marked unsafe. Instead ModReady ships ONLY the four
  BUTR dependency modules (pure managed DLLs, no .exe) and lists BLSE as a
  required mod -- the same approach BetaDeps ships on Nexus without being flagged.
  Bonus: BLSE then stays current on its own (a bundled copy would freeze).

  Builds dist\ModReady-v<ver>.zip from the vendored installer\payload\, laid out
  so the user drag-extracts it into the Bannerlord ROOT:

    Modules\Bannerlord.Harmony\        (+ the other 3 dependency modules)
    licenses\                    <- third-party MIT notices
    README.txt                   <- install instructions (BLSE required first)

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
$payloadLic     = Join-Path $Payload 'LICENSES'

# --- sanity: payload present -------------------------------------------------
if (-not (Test-Path $payloadModules)) { Fail "payload\Modules not found. Run .\scripts\sync-payload.ps1 first." }
foreach ($m in $deps) {
  if (-not (Test-Path (Join-Path $payloadModules $m))) { Fail "payload\Modules\$m missing -- run sync-payload.ps1." }
}
if (Test-Path (Join-Path $payloadModules 'BetaDeps')) { Fail "payload\Modules\BetaDeps must NOT be present -- ModReady is the dependency stack only." }

# --- assemble a staging tree shaped like the Bannerlord root -----------------
$Stage = Join-Path $Dist ("_zipstage_v$Version")
if (Test-Path $Stage) { Remove-Item $Stage -Recurse -Force }
New-Item -ItemType Directory -Path $Stage | Out-Null

# 4 dependency modules -> Modules\  (NO BLSE -- it's a required mod, not bundled)
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

The four BUTR dependency modules every modern Bannerlord mod needs:
Harmony, UIExtenderEx, ButterLib, and MCM (Mod Configuration Menu).

REQUIRES BLSE FIRST
  ModReady does not include BLSE. Install BLSE (Bannerlord Software Extender)
  from its Nexus page first -- it's the launcher you start the game through:
    https://www.nexusmods.com/mountandblade2bannerlord/mods/1

INSTALL
  1. Install BLSE (above) if you haven't already.
  2. Open your Bannerlord install folder -- the one containing the "bin" and
     "Modules" folders. Typically:
       C:\Program Files (x86)\Steam\steamapps\common\Mount & Blade II Bannerlord
  3. Extract this zip's "Modules" folder into that folder, MERGING when Windows
     asks (this adds files; it does not overwrite the game).
  4. Launch the game through BLSE, enable Harmony, ButterLib, UIExtenderEx and
     MCM (plus any content mods you add later), then Play.

That's it -- you're mod-ready. Add the content mods you want into Modules\.

CREDITS
  The BUTR dependency stack is by BUTR (https://github.com/BUTR). The four
  dependency modules here are clean-room BetaDeps builds. License notices are in
  the licenses\ folder.
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
