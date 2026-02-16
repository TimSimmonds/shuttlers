import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shuttlers/model/expense.dart';
import 'package:shuttlers/ui/widgets/expense_card.dart';

void main() {
  testWidgets('ExpenseCard displays ledger info correctly', (WidgetTester tester) async {
    final date = DateTime(2023, 5, 20);
    final ledger = Ledger(
      date: date,
      type: LedgerType.game,
      members: ['Alice', 'Bob'],
      cost: 10.0,
      membersString: 'Alice, Bob',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExpenseCard(ledger),
        ),
      ),
    );

    expect(find.text('20/05/23'), findsOneWidget);
    expect(find.text('Alice, Bob'), findsOneWidget);
    expect(find.text('£10.00'), findsOneWidget);
  });

  testWidgets('ExpenseCard displays equipment info with italics', (WidgetTester tester) async {
    final date = DateTime(2023, 5, 20);
    final ledger = Ledger(
      date: date,
      type: LedgerType.equipment,
      members: ['Alice'],
      cost: 20.0,
      membersString: 'Alice',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExpenseCard(ledger),
        ),
      ),
    );

    expect(find.text('20/05/23'), findsOneWidget);
    expect(find.text('Equipment - Alice'), findsOneWidget);
    expect(find.text('£20.00'), findsOneWidget);

    final Text dateText = tester.widget<Text>(find.text('20/05/23'));
    expect(dateText.style?.fontStyle, FontStyle.italic);

    final Text memberText = tester.widget<Text>(find.text('Equipment - Alice'));
    expect(memberText.style?.fontStyle, FontStyle.italic);
  });
}
