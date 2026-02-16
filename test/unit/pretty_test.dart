import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers/utils/pretty.dart';

void main() {
  group('pretty utils', () {
    test('prettyMoney should format positive amounts', () {
      expect(prettyMoney(10.0), '£10.00');
      expect(prettyMoney(1.234), '£1.23');
      expect(prettyMoney(0.0), '£0.00');
    });

    test('prettyMoney should format negative amounts correctly', () {
      expect(prettyMoney(-10.0), '-£10.00');
      expect(prettyMoney(-1.23), '-£1.23');
    });

    test('prettyDate should format dates correctly', () {
      final date = DateTime(2023, 5, 20);
      expect(prettyDate(date), '20/05/23');
    });

    test('prettyDateNoYear should format dates without year', () {
      final date = DateTime(2023, 5, 20);
      expect(prettyDateNoYear(date), '20/05');
    });

    test('prettyShare should format shares correctly', () {
      expect(prettyShare('Alice', 10.0), '| Alice    | £10.00 |');
      expect(prettyShare('Bob', -5.5), '| Bob      | -£5.50 |');
    });
  });
}
