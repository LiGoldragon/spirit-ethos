# Stream MVP fields

`Observer.Stream.(Query IntentEvent)` is the source declaration for the
Spirit observation stream.  It is deliberately the only transformer spelling
in this project: `Observer` names the stream and `Stream` names the
transformer.

The generated initiation carries the exact `Query` used to select records.
Successful establishment returns `Stream<IntentEvent>` with a stable generated
stream identity.  The separate generated termination input carries that stream
identity.  A termination against an absent identity refuses as `UnknownStream`;
a second termination of an established identity refuses as `AlreadyClosed`.

This is the delegated MVP shape.  Identity allocation and active-stream state
belong to the Spirit Nexus runtime, while the source remains the single
declaration of the typed query and event shape.  There is no subscription
wrapper, grant token, generic transformer envelope, or deferred construct.
