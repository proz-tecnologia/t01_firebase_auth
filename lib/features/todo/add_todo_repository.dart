import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t01_firebase_auth/features/home/model/todo.dart';

class AddTodoRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<bool> addTodo(TodoModel todoModel) async {
    try {
      final result = await _firestore.collection('todoList').add(todoModel.toMap());
      return result.id.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> updateTodo(TodoModel todoModel) async {
    try {
      await _firestore.collection('todoList').doc(todoModel.id).set(todoModel.toMap());
    } catch (e) {
      rethrow;
    }
  }
}
