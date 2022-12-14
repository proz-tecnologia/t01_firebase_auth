import 'package:flutter/material.dart';
import 'package:t01_firebase_auth/features/home/home_page.dart';
import 'package:t01_firebase_auth/features/sign_in/sign_in_page.dart';
import 'package:t01_firebase_auth/features/splash/splash.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const SplashPage(),
      routes: {
        '/home': (_) => const MyHomePage(title: 'Kaio legal'),
        '/signin': (_) => const SignInPage(),
      },
    );
  }
}
