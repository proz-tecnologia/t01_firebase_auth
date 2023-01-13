import 'model/todo.dart';

abstract class HomeState {}

class HomeInitialState implements HomeState {}

class HomeLogoutState implements HomeState {}

class HomeLoadingState implements HomeState {}

class HomeSuccessState implements HomeState {
  final List<TodoModel> todoList;

  HomeSuccessState(this.todoList);
}

class HomeErrorState implements HomeState {}

class HomeEmptyState implements HomeState {}
