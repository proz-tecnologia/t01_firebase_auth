import 'package:flutter/foundation.dart';
import 'package:t01_firebase_auth/features/sign_in/sign_in_repository.dart';
import 'package:t01_firebase_auth/features/todo/add_todo_repository.dart';
import 'package:t01_firebase_auth/features/todo/add_todo_state.dart';

import '../home/model/todo.dart';

class AddTodoController {
  final AuthRepository _authRepository;
  final AddTodoRepository _addTodoRepository;
  final notifier = ValueNotifier<AddTodoState>(AddTodoInitialState());
  AddTodoState get state => notifier.value;

  AddTodoController(this._authRepository, this._addTodoRepository);
  Future<void> addTodo(String title, String content) async {
    try {
      final userId = _authRepository.currentUser?.uid ?? '';
      final todoModel = TodoModel(
        userId: userId,
        date: DateTime.now(),
        title: title,
        content: content,
      );
      if (await _addTodoRepository.addTodo(todoModel)) {
        notifier.value = AddTodoSuccessState();
      }
      throw Exception();
    } catch (e) {
      notifier.value = AddTodoErrorState();
    }
  }
}
