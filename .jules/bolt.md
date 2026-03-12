## 2024-05-27 - Dart/Flutter Singleton Optimization for Firebase Collections
**Learning:** In Dart/Flutter apps, instantiating database wrapper classes like `Store` without a Singleton pattern causes multiple re-initializations of `DocumentReference` and `CollectionReference` on every page or dialog load.
**Action:** Always verify if database wrapper classes are reusing references (e.g., using a `factory` constructor with a static `_instance`). If not, convert them to a Singleton to reduce garbage collection and memory overhead.
