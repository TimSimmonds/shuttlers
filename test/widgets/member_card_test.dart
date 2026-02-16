import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers/model/member.dart';
import 'package:shuttlers/ui/widgets/member_card.dart';

void main() {
  testWidgets('MemberCard displays member info correctly', (WidgetTester tester) async {
    const member = Member(id: '1', name: 'Alice', bank: 10.0);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MemberCard(member),
        ),
      ),
    );

    expect(find.text('Alice'), findsOneWidget);
    expect(find.text('£10.00'), findsOneWidget);
    expect(find.text('A'), findsOneWidget); // Avatar
  });

  testWidgets('MemberCard displays negative balance in red', (WidgetTester tester) async {
    const member = Member(id: '1', name: 'Bob', bank: -5.0);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MemberCard(member),
        ),
      ),
    );

    expect(find.text('Bob'), findsOneWidget);
    expect(find.text('-£5.00'), findsOneWidget);

    final card = tester.widget<Card>(find.byType(Card));
    expect(card.color, Colors.red.shade100);
  });
}
