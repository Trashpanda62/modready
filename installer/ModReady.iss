; ============================================================================
;  ModReady -- Bannerlord dependency installer (deps-only)
;  Installs the four BUTR dependency modules (Harmony, UIExtenderEx, ButterLib,
;  MCM) into a Mount & Blade II: Bannerlord install so it can run mods.
;
;  Does NOT bundle BLSE. BLSE ships executables, and re-hosting them gets the
;  download flagged by Nexus's malware scanner -- so BLSE is a REQUIRED separate
;  mod (https://www.nexusmods.com/mountandblade2bannerlord/mods/1), which also
;  keeps it updatable on its own. The BetaDeps framework module is likewise NOT
;  shipped -- this is the dependency stack only. BetaDeps.Foundation.dll still
;  ships inside each dependency module's bin: it is their shared resolve-hook
;  shim and they cannot load without it.
;
;  NOTE: the conventional Nexus distribution is the manual-install ZIP
;  (scripts\Build-Zip.ps1) -- Nexus flags Inno .exe installers regardless of
;  contents. This .iss remains for users who want a local installer.
;
;  Build with scripts\Build-Installer.ps1 (runs ISCC against the vendored
;  payload\). Refresh the modules with scripts\sync-payload.ps1.
;  Requires Inno Setup 6 (ISCC.exe).
; ============================================================================

#define AppName "ModReady"
#ifndef AppVersion
  #define AppVersion "1.0.0"
#endif
#define AppPublisher "Maxfield Management Group"

[Setup]
; Keep this AppId STABLE across releases so updates replace in place.
AppId={{D54D4BE0-BC4C-499D-A13E-3041901A9282}
AppName={#AppName}
AppVersion={#AppVersion}
AppPublisher={#AppPublisher}
; The install dir IS the Bannerlord root; resolved by GetBannerlordDir below.
DefaultDirName={code:GetBannerlordDir}
DisableProgramGroupPage=yes
DisableDirPage=no
DirExistsWarning=no
AppendDefaultDirName=no
UsePreviousAppDir=yes
OutputDir=..\dist
OutputBaseFilename=ModReady-v{#AppVersion}
Compression=lzma2
SolidCompression=yes
WizardStyle=modern
ArchitecturesInstallIn64BitMode=x64compatible
; Third-party MIT notices (Harmony/Cecil/MonoMod/Newtonsoft) shown on the license
; page and copied into the install.
LicenseFile=payload\LICENSES\BetaDeps-THIRD-PARTY-LICENSES.txt
SetupLogging=yes

[Files]
; The four BUTR dependency module folders (vendored snapshot in payload\Modules).
; payload\Modules contains ONLY the four deps -- no BetaDeps module folder, no BLSE.
Source: "payload\Modules\*"; DestDir: "{app}\Modules"; Flags: recursesubdirs createallsubdirs ignoreversion
; License notices (third-party MIT for Harmony/Cecil/MonoMod/Newtonsoft).
; Installed under the Harmony dependency module (always present); do NOT target a
; BetaDeps folder -- this installer ships none and must not recreate one.
Source: "payload\LICENSES\*"; DestDir: "{app}\Modules\Bannerlord.Harmony\licenses"; Flags: recursesubdirs createallsubdirs ignoreversion

[UninstallRun]
; Remove the persistent User-scope CREST_SHOW_STUBS env var BetaDeps may set at
; runtime (BLSE launcher hide-stubs opt-out). Best-effort.
Filename: "{sys}\reg.exe"; Parameters: "delete ""HKCU\Environment"" /v CREST_SHOW_STUBS /f"; Flags: runhidden; RunOnceId: "RemoveCrestShowStubsEnv"

[Code]
{ ---- Locate the Bannerlord install ------------------------------------------ }
{ Tries the Steam registry path + the common library location; falls back to the
  well-known default. The user can always browse/correct on the directory page. }
function SteamCommonBannerlord(): String;
var
  SteamPath: String;
begin
  Result := '';
  if RegQueryStringValue(HKCU, 'Software\Valve\Steam', 'SteamPath', SteamPath) then
  begin
    StringChangeEx(SteamPath, '/', '\', True);
    if DirExists(SteamPath + '\steamapps\common\Mount & Blade II Bannerlord') then
      Result := SteamPath + '\steamapps\common\Mount & Blade II Bannerlord';
  end;
end;

function GetBannerlordDir(Param: String): String;
var
  Candidate: String;
begin
  Candidate := SteamCommonBannerlord();
  if Candidate <> '' then
  begin
    Result := Candidate;
    Exit;
  end;
  Candidate := ExpandConstant('{commonpf32}') + '\Steam\steamapps\common\Mount & Blade II Bannerlord';
  if DirExists(Candidate) then
    Result := Candidate
  else
    Result := Candidate; { still the best default to show; user can browse }
end;

{ ---- Validate the chosen folder really is a Bannerlord install -------------- }
function LooksLikeBannerlord(Dir: String): Boolean;
begin
  Result := FileExists(Dir + '\bin\Win64_Shipping_Client\Bannerlord.exe');
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  Result := True;
  if CurPageID = wpSelectDir then
  begin
    if not LooksLikeBannerlord(WizardDirValue) then
    begin
      Result := False;
      MsgBox('That folder does not look like a Mount & Blade II: Bannerlord install '
        + '(no bin\Win64_Shipping_Client\Bannerlord.exe found).' + #13#10#13#10
        + 'Browse to your Bannerlord folder -- the one that contains the "bin" and '
        + '"Modules" folders.', mbError, MB_OK);
    end;
  end;
end;
