## 2026-04-02 - Caching StreamBuilder Streams
**Learning:** `StreamBuilder` widgets calling `.snapshots()` directly in their `build` methods create new stream instances on every rebuild, leading to redundant Firestore subscriptions and UI flickering.
**Action:** Always cache these streams using a `late final` variable within the `initState()` of a `StatefulWidget`. Use `didUpdateWidget` to update the stream if it depends on widget properties.
