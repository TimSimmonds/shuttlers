import 'dart:core';

void main() {
  final items = List.generate(1000, (i) => i);

  final stopwatch1 = Stopwatch()..start();
  for (var i = 0; i < 10000; i++) {
    items.forEach((item) async {
      final a = item + 1;
    });
  }
  stopwatch1.stop();
  print('With async: ${stopwatch1.elapsedMicroseconds} us');

  final stopwatch2 = Stopwatch()..start();
  for (var i = 0; i < 10000; i++) {
    items.forEach((item) {
      final a = item + 1;
    });
  }
  stopwatch2.stop();
  print('Without async: ${stopwatch2.elapsedMicroseconds} us');
}
