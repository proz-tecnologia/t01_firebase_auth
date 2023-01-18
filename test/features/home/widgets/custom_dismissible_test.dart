import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:t01_firebase_auth/features/home/model/todo.dart';
import 'package:t01_firebase_auth/features/home/widgets/custom_dismissible.dart';

void main() {
  testWidgets('CustomDismissible', (tester) async {
    bool wasCalled = false;
    final todoModel = TodoModel(
      id: 'testeId',
      title: 'title',
      date: DateTime.now(),
      userId: 'userIdTeste',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomDismissible(
            todoModel: todoModel,
            deleteTodo: (todoId) async {
              wasCalled = true;
            },
          ),
        ),
      ),
    );

    expect(find.text(todoModel.title), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
    await tester.drag(find.byType(Dismissible), const Offset(-500, 0));
    expect(wasCalled, false);
    await tester.pumpAndSettle(const Duration(milliseconds: 500));
    expect(wasCalled, true);
  });
}
