class Member {
  final String name;
  Member(this.name);
}

void main() {
  final members = List.generate(100, (i) => Member('Member ${100 - i}'));

  // Warmup
  for (int i = 0; i < 1000; i++) {
    List<String> names = [];
    members.forEach((element) {
      names.add(element.name);
    });
    names.sort();
    names.join(", ");
  }

  final stopwatch1 = Stopwatch()..start();
  for (int i = 0; i < 100000; i++) {
    List<String> names = [];
    members.forEach((element) {
      names.add(element.name);
    });
    names.sort();
    names.join(", ");
  }
  stopwatch1.stop();
  print('Baseline: ${stopwatch1.elapsedMilliseconds} ms');

  // Warmup
  for (int i = 0; i < 1000; i++) {
    List<String> names = members.map((e) => e.name).toList()..sort();
    names.join(", ");
  }

  final stopwatch2 = Stopwatch()..start();
  for (int i = 0; i < 100000; i++) {
    List<String> names = members.map((e) => e.name).toList()..sort();
    names.join(", ");
  }
  stopwatch2.stop();
  print('Optimized: ${stopwatch2.elapsedMilliseconds} ms');
}
