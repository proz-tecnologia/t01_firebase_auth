import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:t01_firebase_auth/features/sign_in/sign_in_repository.dart';
import 'package:t01_firebase_auth/shared/analytics.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthRepository>(
      FirebaseRepository(FirebaseAuth.instance));
  getIt.registerSingleton<AnalyticsInterface>(TodoAnalytics());
}
