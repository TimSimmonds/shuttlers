import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers/utils/math.dart';

void main() {
  group('math utils', () {
    test('roundCost should round up to 2 decimal places', () {
      expect(roundCost(1.234), 1.24);
      expect(roundCost(1.235), 1.24);
      expect(roundCost(1.231), 1.24);
      expect(roundCost(1.0), 1.0);
      expect(roundCost(1.23), 1.23);
    });

    test('roundCost should handle negative numbers correctly (ceil)', () {
      // ceil(-1.234 * 100) = ceil(-123.4) = -123. -123 / 100 = -1.23
      expect(roundCost(-1.234), -1.23);
    });
  });
}
