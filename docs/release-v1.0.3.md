# ModReady v1.0.3 — release texts

Artifact: `C:\dev\modready\dist\ModReady-v1.0.3.zip`  ·  Nexus mod 11274  ·  prev: v1.0.2

---

## Nexus changelog (BBCode)

[b]v1.0.3[/b]
[list]
[*]Fixed the Game Pass / Microsoft Store launch crash that v1.0.2 did not fully fix.
[/list]

---

## Steam change note

v1.0.3
- Fixed the Game Pass / Microsoft Store launch crash that v1.0.2 did not fully fix.

---

## GitHub release  (title: v1.0.3 — Game Pass launch fix)

- Fixed the Game Pass / Microsoft Store launch crash that v1.0.2 did not fully fix.

Root cause: the MonoMod detour engine (`MonoMod.RuntimeDetour`) was not preloaded from the module's runtime-specific bin, so on the .NET 6 (Game Pass / Microsoft Store) process it bound the net472 copy and threw `MissingMethodException: ILGenerator.MarkSequencePoint`. It is now preloaded alongside the other MonoMod assemblies, so each process loads the correct build. Steam/GOG unaffected.

Compare: https://github.com/Trashpanda62/modready/compare/v1.0.2...v1.0.3

---

## Nexus sticky post

v1.0.3 is up. If you're on Game Pass / Microsoft Store and v1.0.2 still crashed at launch — this is the real fix. The earlier build shipped the right files but loaded the wrong one for your runtime; that's sorted now. Steam/GOG are unaffected and get the same files as before. Still launched through BLSE, same as always.

Problems? Post your `Modules\Bannerlord.Harmony\runtime.log` and your mod list.

---

## Patreon draft (optional)

ModReady v1.0.3 is out. Game Pass and Microsoft Store players who were still crashing on v1.0.2 can launch now — the dependency stack was shipping the right files but picking the wrong one for the Game Pass runtime, and that's fixed. Steam/GOG players get the same files as before.

Thanks for keeping this going. Grab it on Nexus: https://www.nexusmods.com/mountandblade2bannerlord/mods/11274
