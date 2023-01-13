import 'package:flutter/foundation.dart';
import 'package:t01_firebase_auth/features/home/home_state.dart';
import 'package:t01_firebase_auth/features/sign_in/sign_in_repository.dart';
import 'package:t01_firebase_auth/shared/analytics.dart';
import 'package:t01_firebase_auth/shared/injection.dart';

import 'home_repository.dart';

class HomeController {
  final AuthRepository _repository;
  final HomeRepository _homeRepository;
  HomeController(this._repository, this._homeRepository);
  final notifier = ValueNotifier<HomeState>(HomeInitialState());
  HomeState get state => notifier.value;
  final analytics = getIt.get<AnalyticsInterface>();

  Future<void> signOut() async {
    await _repository.signOut();
    notifier.value = HomeLogoutState();
  }

  Future<void> getTodo() async {
    notifier.value = HomeLoadingState();
    try {
      final userId = _repository.currentUser?.uid;
      final result = await _homeRepository.getTodo(userId ?? '');
      await analytics.logEvent(name: 'getTodo', parameters: {'userId': userId});
      if (result.isEmpty) {
        notifier.value = HomeEmptyState();
        return;
      }
      notifier.value = HomeSuccessState(result);
    } catch (e) {
      notifier.value = HomeErrorState();
    }
  }

  Future<void> deleteTodo(String id) async {
    final result = await _homeRepository.deleteTodo(id);
    if (result) {
      await analytics.logEvent(name: 'deleteTodo', parameters: {'todoId': id});
      final todoList = (state as HomeSuccessState).todoList;
      todoList.removeWhere((todo) => todo.id == id);
      notifier.value = HomeSuccessState(todoList);
    }
  }
}
