import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers/model/expense.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  group('Ledger model', () {
    test('Ledger constructor and properties', () {
      final date = DateTime(2023, 5, 20);
      final ledger = Ledger(
        date: date,
        type: LedgerType.game,
        members: ['Alice', 'Bob'],
        cost: 10.0,
        membersString: 'Alice, Bob',
      );
      expect(ledger.date, date);
      expect(ledger.type, LedgerType.game);
      expect(ledger.members, ['Alice', 'Bob']);
      expect(ledger.cost, 10.0);
      expect(ledger.membersString, 'Alice, Bob');
    });

    test('Ledger.fromMap should create a Ledger object', () {
      final date = DateTime(2023, 5, 20);
      final data = {
        'date': Timestamp.fromDate(date),
        'type': LedgerType.game.index,
        'members': ['Alice', 'Bob'],
        'cost': 10.0,
        'mString': 'Alice, Bob',
      };
      final ledger = Ledger.fromMap(data);
      expect(ledger.date, date);
      expect(ledger.type, LedgerType.game);
      expect(ledger.members, ['Alice', 'Bob']);
      expect(ledger.cost, 10.0);
      expect(ledger.membersString, 'Alice, Bob');
    });

    test('compareTo should sort ledgers by date (descending)', () {
      final a = Ledger(
        date: DateTime(2023, 5, 20),
        type: LedgerType.game,
        members: [],
        cost: 0.0,
        membersString: '',
      );
      final b = Ledger(
        date: DateTime(2023, 5, 21),
        type: LedgerType.game,
        members: [],
        cost: 0.0,
        membersString: '',
      );
      // b.date.compareTo(a.date) = 1 (positive)
      // a.date.compareTo(b.date) = -1 (negative)
      // Ledger.compareTo(other) returns other.date.compareTo(date)
      expect(a.compareTo(b), isPositive);
      expect(b.compareTo(a), isNegative);
      expect(a.compareTo(a), 0);
    });
  });
}
