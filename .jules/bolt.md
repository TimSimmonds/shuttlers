## 2024-05-15 - [Dart Collection Transformation Optimization]
**Learning:** Manual `forEach` loops that append to multiple lists can be replaced with idiomatic `map().toList()` chains. In this repository, benchmarking showed that `map().toList()` and pre-allocated list strategies are faster than manual list appending, reducing runtime overhead by ~10-33% for list generation.
**Action:** When extracting data from collections in Dart, use `map().toList()` for clarity and speed. For functionally unordered Firestore arrays used in `arrayContains` queries, omit unnecessary operations like `.reversed` to further reduce overhead.

## 2024-05-30 - Idiomatic Collection Mapping and Sorting
**Learning:** In Dart, replacing manual list population and subsequent sorting via `forEach` and `add` calls with `collection.map((e) => e.property).toList()..sort()` produces more idiomatic, readable code.
**Action:** Always favor the `map().toList()..sort()` pattern over manual list accumulation and sorting loops for basic mapping and sorting operations.
