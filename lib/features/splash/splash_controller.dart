import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:t01_firebase_auth/features/sign_in/sign_in_repository.dart';
import 'package:t01_firebase_auth/shared/analytics.dart';
import 'package:t01_firebase_auth/shared/injection.dart';

enum SplashState { loading, authenticated, unauthenticated }

class SplashController {
  final AuthRepository _repository;
  SplashController(this._repository);
  final notifier = ValueNotifier<SplashState>(SplashState.loading);
  SplashState get state => notifier.value;
  final crashlytics = FirebaseCrashlytics.instance;
  final analytics = getIt.get<AnalyticsInterface>();

  Future<void> getUser() async {
    await Future.delayed(const Duration(seconds: 3));
    if (_repository.isLogged) {
      await crashlytics.setUserIdentifier(_repository.currentUser?.uid ?? 'loggedOut');
      crashlytics.setCustomKey('userId', _repository.currentUser!.uid);
      crashlytics.setCustomKey('todoId', 'suhaushas');
      await analytics.setUserProperty(name: 'euMesmo', value: 'luan');
      notifier.value = SplashState.authenticated;
    } else {
      notifier.value = SplashState.unauthenticated;
    }
  }
}
