import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers/model/member.dart';

void main() {
  group('Member model', () {
    test('Member constructor and properties', () {
      const member = Member(id: '1', name: 'Alice', bank: 10.0);
      expect(member.id, '1');
      expect(member.name, 'Alice');
      expect(member.bank, 10.0);
    });

    test('Member.fromMap should create a Member object', () {
      final data = {'name': 'Bob', 'bank': 5.5};
      final member = Member.fromMap(data, '2');
      expect(member.id, '2');
      expect(member.name, 'Bob');
      expect(member.bank, 5.5);
    });

    test('Member.fromMap should handle integer bank value', () {
      final data = {'name': 'Charlie', 'bank': 10};
      final member = Member.fromMap(data, '3');
      expect(member.bank, 10.0);
    });

    test('compareTo should sort members by name', () {
      const a = Member(id: '1', name: 'Alice', bank: 0.0);
      const b = Member(id: '2', name: 'Bob', bank: 0.0);
      expect(a.compareTo(b), isNegative);
      expect(b.compareTo(a), isPositive);
      expect(a.compareTo(a), 0);
    });
  });
}
