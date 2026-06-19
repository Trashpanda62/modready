; ============================================================================
;  ModReady -- Bannerlord one-click dependency installer
;  One download that makes a fresh Mount & Blade II: Bannerlord install
;  mod-ready: BLSE (Bannerlord Software Extender) + the four BUTR dependency
;  modules (Harmony, UIExtenderEx, ButterLib, MCM). A new user runs this once,
;  then just drops in the content mods they want.
;
;  Bundles, with permission:
;    - BLSE -- MIT, (c) 2021-2022 BUTR. Its LICENSE ships in
;      {app}\Modules\Bannerlord.Harmony\licenses\ and is shown on the license page.
;    - The four BUTR dependency modules (clean-room BetaDeps builds). The
;      BetaDeps framework module itself is NOT shipped -- this is the dependency
;      stack only. BetaDeps.Foundation.dll still ships inside each dependency
;      module's bin: it is their shared resolve-hook shim and they cannot load
;      without it.
;
;  Build with scripts\Build-Installer.ps1 (runs ISCC against the vendored
;  payload\). Refresh the bundled modules/BLSE with scripts\sync-payload.ps1.
;  Requires Inno Setup 6 (ISCC.exe).
; ============================================================================

#define AppName "ModReady"
#ifndef AppVersion
  #define AppVersion "1.0.0"
#endif
#define AppPublisher "Maxfield Management Group"
#define LauncherExe "Bannerlord.BLSE.LauncherEx.exe"

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
; BLSE's MIT license shown on the license page (satisfies the notice requirement
; up front; the file is also copied into the install).
LicenseFile=payload\LICENSES\BLSE-LICENSE.txt
SetupLogging=yes

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut to the BLSE launcher"; GroupDescription: "Shortcuts:"

[Files]
; The four BUTR dependency module folders (vendored snapshot in payload\Modules).
; payload\Modules contains ONLY the four deps -- no BetaDeps module folder.
Source: "payload\Modules\*"; DestDir: "{app}\Modules"; Flags: recursesubdirs createallsubdirs ignoreversion
; BLSE binaries -> game bin (the documented BLSE install location).
Source: "payload\BLSE\*"; DestDir: "{app}\bin\Win64_Shipping_Client"; Flags: recursesubdirs createallsubdirs ignoreversion
; License notices (BLSE MIT, third-party MIT for Harmony/Cecil/MonoMod/Newtonsoft).
; Installed under the Harmony dependency module (always present); do NOT target a
; BetaDeps folder -- this installer ships none and must not recreate one.
Source: "payload\LICENSES\*"; DestDir: "{app}\Modules\Bannerlord.Harmony\licenses"; Flags: recursesubdirs createallsubdirs ignoreversion

[Icons]
Name: "{autodesktop}\Bannerlord (BLSE)"; Filename: "{app}\bin\Win64_Shipping_Client\{#LauncherExe}"; WorkingDir: "{app}\bin\Win64_Shipping_Client"; Tasks: desktopicon

[Run]
Filename: "{app}\bin\Win64_Shipping_Client\{#LauncherExe}"; Description: "Launch the BLSE launcher now"; Flags: nowait postinstall skipifsilent

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
