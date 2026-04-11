
## 2024-05-30 - Idiomatic Collection Mapping and Sorting
**Learning:** In Dart, replacing manual list population and subsequent sorting via `forEach` and `add` calls with `collection.map((e) => e.property).toList()..sort()` produces more idiomatic, readable code.
**Action:** Always favor the `map().toList()..sort()` pattern over manual list accumulation and sorting loops for basic mapping and sorting operations.
