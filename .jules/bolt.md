## 2024-03-26 - Singleton Pattern for Firestore Store
**Learning:** Instantiating utility classes like `Store` repeatedly across UI screens and dialogs causes unnecessary memory allocations and object creation overhead, especially when they initialize multiple `CollectionReference` and `DocumentReference` objects for Firestore.
**Action:** Implement a Singleton pattern (`factory` constructor returning a static `_instance`) for centralized data utility classes to reuse the same references, minimizing memory footprint and object allocation during widget rebuilds.
