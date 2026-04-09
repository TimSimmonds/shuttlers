import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers/model/member.dart';
import 'package:shuttlers/ui/widgets/member_card_admin.dart';

void main() {
  testWidgets('MemberCardAdmin displays member info correctly', (WidgetTester tester) async {
    const member = Member(id: '1', name: 'Alice', bank: 10.0);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MemberCardAdmin(member),
        ),
      ),
    );

    expect(find.text('Alice'), findsOneWidget);
    expect(find.text('£10.00'), findsOneWidget);
    expect(find.text('A'), findsOneWidget); // Avatar
  });

  testWidgets('MemberCardAdmin displays negative balance in red', (WidgetTester tester) async {
    const member = Member(id: '1', name: 'Bob', bank: -5.0);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MemberCardAdmin(member),
        ),
      ),
    );

    expect(find.text('Bob'), findsOneWidget);
    expect(find.text('-£5.00'), findsOneWidget);

    final card = tester.widget<Card>(find.byType(Card));
    expect(card.color, Colors.red.shade100);
  });

  testWidgets('MemberCardAdmin displays action buttons', (WidgetTester tester) async {
    const member = Member(id: '1', name: 'Charlie', bank: 0.0);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MemberCardAdmin(member),
        ),
      ),
    );

    expect(find.byIcon(Icons.delete), findsOneWidget);
    expect(find.byIcon(Icons.history), findsOneWidget);
    expect(find.byIcon(Icons.add), findsOneWidget);
  });

  testWidgets('MemberCardAdmin opens delete confirmation dialog on tap', (WidgetTester tester) async {
    const member = Member(id: '1', name: 'Dave', bank: 20.0);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: MemberCardAdmin(member),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pumpAndSettle();

    expect(find.text('Warning'), findsOneWidget);
    expect(find.text('You are about to delete Dave. There final balance is £20.00.'), findsOneWidget);
    expect(find.text('CANCEL'), findsOneWidget);
    expect(find.text('DELETE'), findsOneWidget);
  });
}
