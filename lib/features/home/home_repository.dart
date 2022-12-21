import 'model/todo.dart';

abstract class HomeRepository {
  Future<List<TodoModel>> getTodo(String userId);
  Future<bool> deleteTodo(String todoId);
}
