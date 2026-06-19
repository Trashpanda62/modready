# ModReady changelog

## v1.0.1 — 2026-06-19

**Fix: MCM no longer fails with a "dependency conflict" on startup.**

The dependency modules carried a hard assembly reference to an internal helper
DLL (`BetaDeps.Harmony.dll`) that only shipped with the separate BetaDeps mod.
Since ModReady deliberately does **not** include the BetaDeps module, that
reference had nothing to resolve against, and BLSE's loader rejected MCM with:

> Mod Configuration Menu v5.MCM Submodule could not be loaded correctly due to
> a dependency conflict.

The dependency modules are now fully self-contained — the helper DLL is bundled
with the Harmony module (which loads first), so every reference resolves with no
BetaDeps module present. No load-order or configuration change needed; just
install v1.0.1 over v1.0.0.

## v1.0.0 — 2026-06-19

First standalone release. The four BUTR dependency modules most modern
Bannerlord mods need — Harmony, UIExtenderEx, ButterLib, and MCM — in one
manual-install zip. Requires BLSE (installed separately). Clean-room BetaDeps
builds; credit BUTR.
