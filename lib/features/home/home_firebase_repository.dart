import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:t01_firebase_auth/features/home/model/todo.dart';

import 'home_repository.dart';

class HomeFirebaseRepository implements HomeRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<List<TodoModel>> getTodo(String userId) async {
    final result = await _firestore.collection("todoList").where("userId", isEqualTo: userId).get();
    // print(result);
    // print(result.docs);
    // result.docs.forEach(print);
    // result.docs.forEach((doc) {
    //   print(doc.id);
    //   print(doc.data());
    // });
    final todoList = List<TodoModel>.from(result.docs.map((doc) => TodoModel.fromMap(doc.id, doc.data())));
    return todoList;
  }

  @override
  Future<bool> deleteTodo(String todoId) async {
    //throw Exception('teste error');
    try {
      final todo = _firestore.doc("todoList/$todoId");
      if (todo.id.isNotEmpty) {
        await todo.delete();
      }
      return true;
    } catch (e, stackTrace) {
      log("Nao conseguiu deletar", error: e, stackTrace: stackTrace);
      return false;
    }
  }
}
