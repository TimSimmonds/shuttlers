## 2024-05-24 - Avoid async callbacks in forEach for synchronous operations
**Learning:** Using `async` in a `forEach` loop callback when the operations inside are synchronous (e.g., queuing `batch.update()` calls for Firestore) allocates unnecessary `Future` objects. This causes execution overhead for every iteration.
**Action:** Remove `async` from loop callbacks unless `await` is explicitly needed. A benchmark showed a 10x speedup (549k us to 49k us for 1000 items x 10000 iterations) simply by omitting `async` from a no-op loop callback.
