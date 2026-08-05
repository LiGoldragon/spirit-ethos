# spirit-ethos

Canonical authored Ethos source for Spirit's Interface, Nexus, and Sema roots.
The three roots were written fresh for the four-field Spirit model in
`design/Spirit/SpiritSurfaceRemoval-2026-08-03.md`; prior fixtures and runtime
schemas were consulted only as behavioral evidence.

The Ethos header is `.1`, the currently supported Ethos file-format and grammar
version. It is deliberately separate from the active Spirit v14 storage and
wire model. `Entry` has exactly `Domains`, `Kind`, `Description`, and
`Importance`; record identity is stable. Ordinary reads are
`Observe`, `Lookup`, `LookupStash`, `Count`, `Marker`, and `Version`.
`Query` retains its five independent dimensions: `DomainMatch`, `KeywordMatch`,
`TextMatch`, `SelectedKind`, and `ImportanceSelection`.  The v14 cut removes
only the selectors ruled out of the active model; it does not reduce these
ordinary read semantics.
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

## Deferred integration proof

The new Sema declaration gives records their stable `RecordIdentifier` key and
migrations their source-schema-version key.  Whether generated Sema family
identities can open an existing v14 store is intentionally not asserted here.
That is a required integration proof once generated code exists.  If the
families prove incompatible, the resulting fresh-store projection, rollback,
and migration authority need an explicit decision; this source project does
not introduce a transition.

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
