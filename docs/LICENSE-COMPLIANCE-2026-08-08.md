# Nexus moderation — LGPL claim re: Bannerlord.UIExtenderEx (2026-08-08)

Nexus mod 11274 (ModReady) was hidden pending review. Staff message (Myrddin):
"This mod is in violation of the LGPL License from Bannerlord UI Extender Ex.
Please meet this criteria on the page including source code links for both
projects and full stated changes."

## What was verified locally (2026-08-08)

| Check | Result |
|---|---|
| BUTR binaries in the shipped zip (`framework/dist/ModReady-v1.1.0.zip`) | **None.** Every module DLL is a ModReady build |
| `Bannerlord.UIExtenderEx.dll` assembly metadata | Company `Maxfield Management Group`, Product `ModReady`, `Copyright (c) 2026 Maxfield Management Group. MIT License.`, 73 KB (upstream is several times larger) |
| Same for `Bannerlord.ButterLib.dll`, `Bannerlord.Harmony.dll`, `MCMv5.dll` | Identical MMG/ModReady/MIT metadata |
| BUTR source vendored in `framework/` | None. `decomp/` holds only decompiled **TaleWorlds** game assemblies; `butr-api-audit.txt` is a reflection dump of *member names and referencing assemblies* (API surface), not implementation |
| Source of the shim | `framework/src/ModReady.UIExtenderEx/` — 329 lines of hand-written C#, header comment states "clean-room re-implementation … MIT, copyright 2026 Maxfield Management Group" |
| Notice already shipped to users | `Modules/ModReady/THIRD-PARTY-LICENSES.txt` in the zip: lists the four MIT third-party libs actually redistributed, then states the BUTR-named DLLs are "clean-room re-implementations of the corresponding public API surfaces" |
| Public source repos | `github.com/Trashpanda62/modready` and `github.com/Trashpanda62/modready-framework` — both **public**, both had **no LICENSE file** until today (added) |

Conclusion: no LGPL-covered code is distributed, so LGPL §4/§5 obligations
(source of the covered work, stated changes) do not attach. What *does* invite
the report is that the shipped assembly, module Id, module name and version
line all claim the upstream identity on purpose
(`framework/docs/VERSION-POLICY.md` calls them "impersonation assemblies", and
pins `.99` patch numbers to sort above real upstream releases).

## Fixes applied locally (uncommitted)

- `C:\dev\modready\LICENSE` — MIT + provenance/non-affiliation note
- `C:\dev\modready\framework\LICENSE` — MIT + clean-room provenance note

## Draft reply to Nexus staff (paste into the file's "report this file" thread)

> Thanks for the notice — happy to fix whatever the staff need, and I'd rather
> over-document this than leave it ambiguous.
>
> To state the facts of the file first: ModReady does not bundle, fork, patch
> or statically link Bannerlord.UIExtenderEx. No BUTR source or binary is in
> any file I've uploaded. The archive contains a DLL named
> `Bannerlord.UIExtenderEx.dll`, but it's my own clean-room implementation of
> that project's public API surface — written from the public type/member
> signatures so that mods compiled against the API load unmodified. It's about
> 73 KB against upstream's several hundred, and its assembly metadata reads
> Company "Maxfield Management Group", Product "ModReady", "Copyright (c) 2026
> Maxfield Management Group. MIT License." The download has said so since
> release, in `Modules/ModReady/THIRD-PARTY-LICENSES.txt`, which lists the four
> MIT libraries I actually redistribute (Harmony, Mono.Cecil, MonoMod,
> Newtonsoft.Json) and then states the BUTR-named DLLs are clean-room
> re-implementations.
>
> Since there is no LGPL-covered code in the upload, there's no upstream source
> or change list to publish — but the request is reasonable on its face, because
> the page never explained any of the above. I've now:
>
> 1. Added a "Licensing and provenance" section to the description stating the
>    licence (MIT), that ModReady is not affiliated with or derived from BUTR,
>    and why the DLL carries that name.
> 2. Linked my full source for the modules in question:
>    https://github.com/Trashpanda62/modready-framework (the UIExtenderEx-API
>    shim is `src/ModReady.UIExtenderEx/`) and the release repo
>    https://github.com/Trashpanda62/modready
> 3. Linked the upstream project it is API-compatible with:
>    https://github.com/BUTR/Bannerlord.UIExtenderEx
> 4. Added a LICENSE file to both repositories.
> 5. Corrected the page permissions, which said files may not be modified — that
>    contradicted my own MIT licence.
>
> If the staff or BUTR can point to any specific file, type or byte in my upload
> that is actually theirs, I'll pull the file immediately and remove or replace
> it — I have no interest in shipping anyone else's code without their terms.
> If instead the concern is that my DLL takes their module name and Id, tell me
> that's the issue and I'll discuss renaming/versioning rather than argue about
> it. Either way I'll make the change you ask for.

## Draft Nexus description block (BBCode)

```bbcode
[size=4][b]Licensing and provenance[/b][/size]

ModReady is [b]MIT licensed[/b] and is [b]not affiliated with, endorsed by, or derived from BUTR[/b].

ModReady ships modules named [i]Bannerlord.Harmony[/i], [i]Bannerlord.UIExtenderEx[/i], [i]Bannerlord.ButterLib[/i] and [i]MCM[/i]. These are [b]clean-room re-implementations of those projects' public API surfaces[/b], written from scratch for this mod so that mods built against those APIs load unmodified. They contain [b]no BUTR source or binary code[/b], and no code from them is copied, decompiled or repackaged. The DLL metadata in every file identifies the author as Maxfield Management Group under the MIT licence.

[b]Full source for everything ModReady ships:[/b]
[list]
[*]Framework source (incl. the UIExtenderEx-API module, [i]src/ModReady.UIExtenderEx[/i]): [url=https://github.com/Trashpanda62/modready-framework]github.com/Trashpanda62/modready-framework[/url]
[*]Release repo: [url=https://github.com/Trashpanda62/modready]github.com/Trashpanda62/modready[/url]
[/list]

[b]The upstream projects ModReady is API-compatible with[/b] — separate projects, by BUTR, under their own licences (Bannerlord.UIExtenderEx is LGPL-3.0). If you want the originals, get them from BUTR:
[list]
[*][url=https://github.com/BUTR/Bannerlord.UIExtenderEx]github.com/BUTR/Bannerlord.UIExtenderEx[/url] (LGPL-3.0)
[*][url=https://github.com/BUTR/Bannerlord.ButterLib]github.com/BUTR/Bannerlord.ButterLib[/url]
[*][url=https://github.com/BUTR/Bannerlord.MBOptionScreen]github.com/BUTR/Bannerlord.MBOptionScreen[/url]
[*][url=https://github.com/BUTR/Bannerlord.Harmony]github.com/BUTR/Bannerlord.Harmony[/url]
[/list]

[b]Third-party libraries actually redistributed[/b] (all MIT, notices in [i]Modules/ModReady/THIRD-PARTY-LICENSES.txt[/i] inside the download): Harmony (Andreas Pardeike), Mono.Cecil (Jean-Baptiste Evain), MonoMod, Newtonsoft.Json (James Newton-King).

Credit where it's due: BUTR's stack is the reason the Bannerlord modding ecosystem works at all. ModReady exists to install a matched, version-locked set in one download, not to replace their work upstream.
```

## Open decisions for Steve

1. **Page permissions.** The listing says "not allowed to modify my files under any
   circumstances" while the code is MIT. Contradiction; pick one. Recommend
   loosening the permission fields to match MIT.
2. **Name/version shadowing** — the real grievance, and not something the reply
   above resolves. `VERSION-POLICY.md` deliberately stamps `2.14.99.0` so ModReady's
   DLL sorts above every genuine UIExtenderEx release, and the module Id is
   identical, so ModReady wins the load slot wherever both are installed. That is
   defensible as compatibility engineering and indefensible-sounding if BUTR frames
   it as hijacking. Decide whether to keep it, or move to a distinct module Id with
   an explicit "provides" alias, before the argument gets made for you.
3. **Copyright holder string.** Everything shipped says "Maxfield Management Group".
   Per vault notes MMG is Tari and Dale's entity, not yours — if the intended holder
   is Orion or you personally, this is the moment to correct it, not mid-dispute.
