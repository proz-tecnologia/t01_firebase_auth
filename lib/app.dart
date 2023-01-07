import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:t01_firebase_auth/features/home/home_page.dart';
import 'package:t01_firebase_auth/features/sign_in/sign_in_page.dart';
import 'package:t01_firebase_auth/features/splash/splash.dart';

import 'features/todo/add_todo_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashPage(),
      navigatorObservers: [FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance)],
      routes: {
        '/home': (_) => const MyHomePage(title: 'Kaio legal'),
        '/add-todo': (context) {
          final args = (ModalRoute.of(context)?.settings.arguments ?? {}) as Map;
          return AddTodoPage(
            pageTitle: args['pageTitle'] ?? 'Kaio do albergue',
            todo: args['todo'],
            buttonTitle: args['buttonTitle'],
          );
        },
        '/signin': (_) => const SignInPage(),
      },
    );
  }
}
