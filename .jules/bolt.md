## 2024-05-18 - Cached StreamBuilder Streams
**Learning:** Found a common Flutter performance anti-pattern where `Store().<streamMethod>()` is called directly in a `StreamBuilder`'s `stream` property within a `build` method. This forces the stream to be recreated on every widget rebuild, causing redundant stream subscriptions, UI flickering, and unnecessary Firestore reads.
**Action:** Always cache streams used by `StreamBuilder` inside `initState` (and update them in `didUpdateWidget` if they depend on widget properties) to ensure the stream is created exactly once per component lifecycle.
