import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:t01_firebase_auth/shared/injection.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setup();
  runApp(const MyApp());
}
