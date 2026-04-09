import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shuttlers/model/expense.dart';
import 'package:shuttlers/model/member.dart';

import 'package:shuttlers/data.dart';
import 'package:shuttlers/utils/math.dart';

class Store {
  late final FirebaseFirestore _firestore;

  Store({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    overview = _firestore.collection(overviewRef).doc('0');
    member = _firestore.collection(memberRef);
    ledger = _firestore.collection(ledgerRef);
  }

  late final DocumentReference overview;
  late final CollectionReference member;
  late final CollectionReference ledger;

  //members orded by name
  Stream<QuerySnapshot<Object?>> membersStream() {
    return member.orderBy('name').snapshots();
  }

  Stream<QuerySnapshot> historyStream(Member data) {
    return ledger
        .orderBy('date', descending: true)
        .where('members', arrayContains: data.id)
        .snapshots();
  }

  ///ledgers with category 1 will be shown here and ordered by date
  Stream<QuerySnapshot<Object?>> ledgerStream() {
    return ledger
        .orderBy('date', descending: true)
        .where('category', isEqualTo: 1)
        .snapshots();
  }

  Stream<DocumentSnapshot<Object?>> overviewStream() {
    return overview.snapshots();
  }

  //add member to DB
  Future<void> addMember(Member data) async {
    WriteBatch batch = _firestore.batch();

    batch.update(overview, {'bank': FieldValue.increment(data.bank)});
    DocumentReference newMember = member.doc();
    batch.set(newMember, {'name': data.name, 'bank': data.bank});
    batch.set(ledger.doc(), {
      'date': Timestamp.now(),
      'members': newMember.id,
      'cost': data.bank,
      'type': 0,
      'category': 0,
    });

    await batch.commit();
  }

  Future<void> addFunds({
    required Member data,
    required double funds,
    required IncomeType type,
    required DateTime date,
  }) async {
    WriteBatch batch = _firestore.batch();

    batch.update(overview, {'bank': FieldValue.increment(funds)});
    batch.update(member.doc(data.id), {'bank': FieldValue.increment(funds)});

    batch.set(ledger.doc(), {
      'date': Timestamp.fromDate(date),
      'members': data.id,
      'cost': funds,
      'type': type.index,
      'category': 0,
    });

    await batch.commit();
  }

  Future<void> addExpenditure({
    required DateTime date,
    required List<Member> members,
    required double cost,
    required ExpenseType type,
    required int catergory,
  }) async {
    WriteBatch batch = _firestore.batch();

    batch.update(overview, {'bank': FieldValue.increment(-cost)});

    double _costPerMember = roundCost(cost / members.length);
    members.forEach((data) async {
      batch.update(member.doc(data.id), {
        'bank': FieldValue.increment(-_costPerMember),
      });
    });

    //this can be done better, i'm sure of it
    List<String> memberIds = members.reversed.map((m) => m.id).toList();
    List<String> memberString = members.map((m) => m.name).toList()..sort();
    String mString = memberString.join(', ');

    batch.set(ledger.doc(), {
      'date': Timestamp.fromDate(date),
      'members': memberIds,
      'cost': cost,
      'type': type.index + 2,
      'category': catergory,
      'mString': mString,
    });

    await batch.commit();
  }
}
