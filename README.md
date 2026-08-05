# spirit-ethos

Canonical authored Ethos source for Spirit's Interface, Nexus, and Sema roots.
The three roots were written fresh for the four-field Spirit model in
`design/Spirit/SpiritSurfaceRemoval-2026-08-03.md`; prior fixtures and runtime
schemas were consulted only as behavioral evidence.

The Ethos header is `.1`, the currently supported Ethos file-format and grammar
version. It is deliberately separate from the active Spirit v14 storage and
wire model. `Entry` has exactly `Domains`, `Kind`, `Description`, and
`Importance`; record identity is stable. `Magnitude` preserves its complete
v14 ordering: `Zero`, `Minimum`, `VeryLow`, `Low`, `Medium`, `High`,
`VeryHigh`, and `Maximum`. Ordinary reads are
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

## Sealed allocation evidence

`allocation-manifest.nota` is the canonical Universal and Rust identity
manifest for these roots.  It was obtained by allocating the complete declared
surface, generated Interface roles and lifecycle terms, family fields, and
current Ethos/Rust grammar terms through a freshly created isolated
`sema-translator` store.  `allocation-receipt.nota` retains its typed request
digests, operation keys, allocator revisions, and database markers.  The
allocator returned the manifest in canonical lexical order; its request used
the documented source/declaration order.

`batch-config.json` is a mechanical consumer configuration of that sealed
manifest.  It has no provisional `1000`-series identities and is checked
against the receipt manifest for exact name, identity, order, and uniqueness.
The retained fingerprints for `Integer`, `String`, and `Vector` are the
published v14 assembly evidence in `language-engine-witness` revision
`efe8ed3d5ea53f280b93cc1f2f131d92ef781832`; `Domain` remains bound to the
exact `signal-domain` revision recorded in the configuration.  A type without
a storage leaf carries a Rust path only, never an invented fingerprint.

This evidence is append-only.  Changing an identity, receipt, allocation set,
or external storage contract requires a new explicit allocation decision; it
is not an ordinary source edit.

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
