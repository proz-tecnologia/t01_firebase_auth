import 'package:flutter/cupertino.dart';

import 'sign_in_repository.dart';
import 'sign_in_state.dart';

class SignInController {
  final Repository _repository;
  SignInController(this._repository);
  final notifier = ValueNotifier<SignInState>(InitialSignInState());
  SignInState get state => notifier.value;

  Future<void> login(String email, String password) async {
    notifier.value = LoadingSignInState();
    try {
      await Future.delayed(const Duration(seconds: 2));
      await _repository.login(email, password);
      notifier.value = SuccessSignInState();
    } catch (e, stackTrace) {
      notifier.value = ErrorSignInState();
    }
  }

  Future<void> register(String email, String password) async {
    notifier.value = LoadingSignInState();
    try {
      await Future.delayed(const Duration(seconds: 2));
      await _repository.register(email, password);
      notifier.value = SuccessSignInState();
    } catch (e, stackTrace) {
      notifier.value = ErrorSignInState();
    }
  }
}
