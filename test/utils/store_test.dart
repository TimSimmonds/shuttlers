import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers/data.dart';
import 'package:shuttlers/model/expense.dart';
import 'package:shuttlers/model/member.dart';
import 'package:shuttlers/utils/store.dart';

void main() {
  late FakeFirebaseFirestore fakeFirestore;
  late Store store;

  setUp(() async {
    fakeFirestore = FakeFirebaseFirestore();

    // Setup initial documents so the streams and updates don't fail on missing docs
    await fakeFirestore.collection(overviewRef).doc('0').set({'bank': 0.0});

    store = Store(firestore: fakeFirestore);
  });


  group('Stream Getters', () {
    test('membersStream returns members ordered by name', () async {
      await fakeFirestore.collection(memberRef).add({'name': 'Zack', 'bank': 0.0});
      await fakeFirestore.collection(memberRef).add({'name': 'Alice', 'bank': 0.0});

      final stream = store.membersStream();
      final snapshot = await stream.first;

      expect(snapshot.docs.length, 2);
      expect((snapshot.docs[0].data() as Map)['name'], 'Alice');
      expect((snapshot.docs[1].data() as Map)['name'], 'Zack');
    });

    test('historyStream returns ledgers for a specific member ordered by date', () async {
      final memberId = 'member1';
      final member = Member(id: memberId, name: 'Alice', bank: 0.0);

      await fakeFirestore.collection(ledgerRef).add({
        'date': Timestamp.fromDate(DateTime(2023, 1, 1)),
        'members': [memberId, 'otherMember'],
      });
      await fakeFirestore.collection(ledgerRef).add({
        'date': Timestamp.fromDate(DateTime(2023, 1, 3)),
        'members': [memberId],
      });
      await fakeFirestore.collection(ledgerRef).add({
        'date': Timestamp.fromDate(DateTime(2023, 1, 2)),
        'members': ['otherMember'], // Should not be included
      });

      final stream = store.historyStream(member);
      final snapshot = await stream.first;

      expect(snapshot.docs.length, 2);
      // Descending order
      expect((snapshot.docs[0].data() as Map)['date'], Timestamp.fromDate(DateTime(2023, 1, 3)));
      expect((snapshot.docs[1].data() as Map)['date'], Timestamp.fromDate(DateTime(2023, 1, 1)));
    });

    test('ledgerStream returns ledgers with category 1 ordered by date', () async {
      await fakeFirestore.collection(ledgerRef).add({
        'date': Timestamp.fromDate(DateTime(2023, 1, 1)),
        'category': 1,
      });
      await fakeFirestore.collection(ledgerRef).add({
        'date': Timestamp.fromDate(DateTime(2023, 1, 3)),
        'category': 1,
      });
      await fakeFirestore.collection(ledgerRef).add({
        'date': Timestamp.fromDate(DateTime(2023, 1, 2)),
        'category': 0, // Should not be included
      });

      final stream = store.ledgerStream();
      final snapshot = await stream.first;

      expect(snapshot.docs.length, 2);
      // Descending order
      expect((snapshot.docs[0].data() as Map)['date'], Timestamp.fromDate(DateTime(2023, 1, 3)));
      expect((snapshot.docs[1].data() as Map)['date'], Timestamp.fromDate(DateTime(2023, 1, 1)));
    });

    test('overviewStream returns the overview document', () async {
      final stream = store.overviewStream();
      final snapshot = await stream.first;

      expect(snapshot.exists, true);
      expect((snapshot.data() as Map)['bank'], 0.0);
    });
  });

  group('Mutations', () {
    test('addMember adds member and updates overview and ledger', () async {
      // Re-initialize overview because tearDown clears everything,
      // but setUp might not run correctly if we rely on global fakeFirestore state in fake_cloud_firestore without proper reset
      await fakeFirestore.collection(overviewRef).doc('0').set({'bank': 0.0});

      final newMember = Member(id: 'new1', name: 'Bob', bank: 50.0);

      await store.addMember(newMember);

      // Verify overview bank is updated
      final overviewDoc = await fakeFirestore.collection(overviewRef).doc('0').get();
      expect(overviewDoc.data()?['bank'], 50.0);

      // Verify member is added
      final membersQuery = await fakeFirestore.collection(memberRef).get();
      expect(membersQuery.docs.length, 1);
      final memberDoc = membersQuery.docs.first;
      expect(memberDoc.data()['name'], 'Bob');
      expect(memberDoc.data()['bank'], 50.0);

      // Verify ledger is created
      final ledgerQuery = await fakeFirestore.collection(ledgerRef).get();
      expect(ledgerQuery.docs.length, 1);
      final ledgerDoc = ledgerQuery.docs.first;
      expect(ledgerDoc.data()['members'], memberDoc.id);
      expect(ledgerDoc.data()['cost'], 50.0);
      expect(ledgerDoc.data()['type'], 0);
      expect(ledgerDoc.data()['category'], 0);
    });

    test('addFunds increments member/overview bank and creates ledger', () async {
      await fakeFirestore.collection(overviewRef).doc('0').set({'bank': 0.0});

      final date = DateTime(2023, 1, 1);
      final memberId = 'member2';
      final member = Member(id: memberId, name: 'Charlie', bank: 10.0);

      // Seed the existing member document
      await fakeFirestore.collection(memberRef).doc(memberId).set({
        'name': 'Charlie',
        'bank': 10.0,
      });

      await store.addFunds(
        data: member,
        funds: 20.0,
        type: IncomeType.deposit,
        date: date,
      );

      // Verify overview bank is incremented by 20
      final overviewDoc = await fakeFirestore.collection(overviewRef).doc('0').get();
      expect(overviewDoc.data()?['bank'], 20.0); // 0 + 20

      // Verify member bank is incremented by 20
      final memberDoc = await fakeFirestore.collection(memberRef).doc(memberId).get();
      expect(memberDoc.data()?['bank'], 30.0); // 10 + 20

      // Verify ledger is created
      final ledgerQuery = await fakeFirestore.collection(ledgerRef).get();
      expect(ledgerQuery.docs.length, 1);
      final ledgerDoc = ledgerQuery.docs.first;
      expect(ledgerDoc.data()['members'], memberId);
      expect(ledgerDoc.data()['cost'], 20.0);
      expect(ledgerDoc.data()['type'], IncomeType.deposit.index);
      expect(ledgerDoc.data()['category'], 0);
      expect(ledgerDoc.data()['date'], Timestamp.fromDate(date));
    });

    test('addExpenditure decrements bank and creates expense ledger', () async {
      await fakeFirestore.collection(overviewRef).doc('0').set({'bank': 100.0});

      final date = DateTime(2023, 1, 1);
      final member1 = Member(id: 'member1', name: 'Alice', bank: 10.0);
      final member2 = Member(id: 'member2', name: 'Bob', bank: 20.0);

      // Seed the existing member documents and overview
      await fakeFirestore.collection(memberRef).doc(member1.id).set({'name': 'Alice', 'bank': 10.0});
      await fakeFirestore.collection(memberRef).doc(member2.id).set({'name': 'Bob', 'bank': 20.0});
      await fakeFirestore.collection(overviewRef).doc('0').set({'bank': 100.0});

      await store.addExpenditure(
        date: date,
        members: [member1, member2],
        cost: 30.0,
        type: ExpenseType.game,
        catergory: 1, // 'catergory' with typo matching the implementation
      );

      // Verify overview bank is decremented by cost
      final overviewDoc = await fakeFirestore.collection(overviewRef).doc('0').get();
      expect(overviewDoc.data()?['bank'], 70.0); // 100 - 30

      // Verify member bank is decremented by cost / members.length (30 / 2 = 15)
      final memberDoc1 = await fakeFirestore.collection(memberRef).doc(member1.id).get();
      expect(memberDoc1.data()?['bank'], -5.0); // 10 - 15

      final memberDoc2 = await fakeFirestore.collection(memberRef).doc(member2.id).get();
      expect(memberDoc2.data()?['bank'], 5.0); // 20 - 15

      // Verify ledger is created
      final ledgerQuery = await fakeFirestore.collection(ledgerRef).get();
      expect(ledgerQuery.docs.length, 1);
      final ledgerDoc = ledgerQuery.docs.first;
      expect(ledgerDoc.data()['cost'], 30.0);
      expect(ledgerDoc.data()['type'], ExpenseType.game.index + 2);
      expect(ledgerDoc.data()['category'], 1);
      expect(ledgerDoc.data()['mString'], 'Alice, Bob');
      expect(ledgerDoc.data()['date'], Timestamp.fromDate(date));
      // Store reverses before adding ids for some reason
      expect(ledgerDoc.data()['members'], ['member2', 'member1']);
    });
  });
}
