## 2024-05-18 - [Flutter StreamBuilder Optimization]
**Learning:** `StreamBuilder` widgets calling `.snapshots()` directly in their `build` methods (e.g., via `Store().membersStream()`) create new stream instances on every rebuild, leading to redundant Firestore subscriptions and UI flickering.
**Action:** Always cache these streams using a `late final` variable within the `initState()` of a `StatefulWidget` to ensure the stream is only created once per widget lifecycle.
