import 'package:firebase_analytics/firebase_analytics.dart';

abstract class AnalyticsInterface {
  Future<void> logEvent({required String name, Map<String, Object?>? parameters});
  Future<void> setUserProperty({required String name, required String? value});
}

class TodoAnalytics implements AnalyticsInterface {
  TodoAnalytics();
  final analytics = FirebaseAnalytics.instance;

  @override
  Future<void> logEvent({required String name, Map<String, Object?>? parameters}) async {
    await analytics.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> setUserProperty({required String name, required String? value}) async {
    await analytics.setUserProperty(name: name, value: value);
  }
}
