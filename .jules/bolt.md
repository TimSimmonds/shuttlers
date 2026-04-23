
## 2024-05-30 - Idiomatic Collection Mapping and Sorting
**Learning:** In Dart, replacing manual list population and subsequent sorting via `forEach` and `add` calls with `collection.map((e) => e.property).toList()..sort()` produces more idiomatic, readable code.
**Action:** Always favor the `map().toList()..sort()` pattern over manual list accumulation and sorting loops for basic mapping and sorting operations.
## 2024-05-30 - StreamBuilder Caching
**Learning:** Instantiating streams directly in the `build` method of a `StreamBuilder` causes redundant network calls and UI flickering on every rebuild.
**Action:** Always cache streams in a `late final Stream` variable within `initState` for StatefulWidgets. When the stream depends on a widget parameter, use `didUpdateWidget` to appropriately recreate the cached stream.
