import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t01_firebase_auth/features/home/model/todo.dart';

class AddTodoRepository {
  final _firestore = FirebaseFirestore.instance;

  Future<bool> addTodo(TodoModel todoModel) async {
    try {
      final result = await _firestore.collection('todoList').add(todoModel.toMap());
      //Update de um doc
      //await _firestore.collection('todoList').doc(result.id).set(todoModel.toMap());
      return result.id.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}
