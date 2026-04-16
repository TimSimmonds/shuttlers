
## 2024-05-30 - Idiomatic Collection Mapping and Sorting
**Learning:** In Dart, replacing manual list population and subsequent sorting via `forEach` and `add` calls with `collection.map((e) => e.property).toList()..sort()` produces more idiomatic, readable code.
**Action:** Always favor the `map().toList()..sort()` pattern over manual list accumulation and sorting loops for basic mapping and sorting operations.
## 2024-05-30 - StreamBuilder Caching in StatefulWidgets
**Learning:** `StreamBuilder` widgets calling `.snapshots()` or stream generators directly in their `build` methods create new stream subscriptions on every rebuild, causing UI flickering and unnecessary memory/CPU overhead, especially when connected to a `Store` or Firestore instance.
**Action:** Always cache these streams using a `late final Stream` variable within the `initState()` of a `StatefulWidget`, and update them in `didUpdateWidget` if they depend on widget properties.
