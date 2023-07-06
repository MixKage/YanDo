import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yando/database/local_data.dart';
import 'package:yando/main.dart';

void main() {
  testWidgets('Create quick task', (WidgetTester tester) async {
    await LD.instance.testInit();
    await tester.pumpWidget(const MyApp());

    await tester.enterText(
      find.byKey(const ValueKey('textFieldCreateTask')),
      'testCreatedTask',
    );
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(find.text('testCreatedTask'), findsOneWidget);
  });
}
