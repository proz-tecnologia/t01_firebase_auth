import 'package:flutter/foundation.dart';
import 'package:t01_firebase_auth/features/home/home_state.dart';
import 'package:t01_firebase_auth/features/sign_in/sign_in_repository.dart';

import 'home_repository.dart';

class HomeController {
  final AuthRepository _repository;
  final HomeRepository _homeRepository;
  HomeController(this._repository, this._homeRepository);
  final notifier = ValueNotifier<HomeState>(HomeInitialState());
  HomeState get state => notifier.value;

  Future<void> signOut() async {
    await _repository.signOut();
    notifier.value = HomeLogoutState();
  }

  Future<void> getTodo() async {
    notifier.value = HomeLoadingState();
    try {
      final userId = _repository.currentUser?.uid;
      final result = await _homeRepository.getTodo(userId ?? '');
      notifier.value = HomeSuccessState(result);
    } catch (e) {
      notifier.value = HomeErrorState();
    }
  }
}
