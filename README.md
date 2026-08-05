# spirit-ethos

Canonical authored Ethos source for Spirit's Interface, Nexus, and Sema roots.
The three roots were written fresh for the four-field Spirit model in
`design/Spirit/SpiritSurfaceRemoval-2026-08-03.md`; prior fixtures and runtime
schemas were consulted only as behavioral evidence.

The active contract is v14-only.  `Entry` has exactly `Domains`, `Kind`,
`Description`, and `Importance`; record identity is stable.  Ordinary reads are
`Observe`, `Lookup`, `LookupStash`, `Count`, `Marker`, and `Version`.
Admission and explicit lifecycle behavior remain Nexus responsibilities.  Sema
persists records plus the one v13-to-v14 migration receipt; its active families
are records and migrations.

`Observer.Stream.(Query IntentEvent)` uses the ruled standalone transformer
syntax.  It generates a live `Stream<IntentEvent>` and a distinct typed
termination input.  The provisional ownership and fields are documented in
[design/provisional-stream-fields.md](design/provisional-stream-fields.md).

This repository contains authored source only.  Consumer repositories may
check in generated Rust only when it is generated from an exact pushed revision
of these roots, with freshness and provenance checks.

## Provenance

The source follows the controlling 2026-08-04 Protos syntax rulings: curly
strings, `String`, bare-angle type application, and standalone
`Name.Transformer.(...)` applications.  It does not use a section-supplied
transformer, a generic application carrier, deferred semantics, or legacy
string forms.

Run the reproducible source gate with:

```sh
nix flake check --option eval-cache false --option substituters '' -L
```
