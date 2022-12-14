import 'package:firebase_auth/firebase_auth.dart';
import 'package:t01_firebase_auth/shared/user_model.dart';

abstract class Repository {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String email, String password);
}

class FirebaseRepository implements Repository {
  FirebaseAuth get _firebase => FirebaseAuth.instance;
  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final result = await _firebase.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (result.user != null) {
        return UserModel(name: '', email: email);
      }
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> register(String email, String password) async {
    try {
      final result = await _firebase.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //Para mandar o name, use o updateDisplayName
      //_firebase.currentUser.updateDisplayName(displayName)
      if (result.user != null) {
        return UserModel(name: '', email: email);
      }
      throw Exception();
    } catch (e) {
      rethrow;
    }
  }
}
