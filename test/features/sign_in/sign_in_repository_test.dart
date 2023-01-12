import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:t01_firebase_auth/features/sign_in/sign_in_repository.dart';
import 'package:t01_firebase_auth/shared/user_model.dart';

class FirebaseMock extends Mock implements FirebaseAuth {}

class UserCredentialMock extends Mock implements UserCredential {}

class UserMock extends Mock implements User {}

void main() {
  //arrange
  late FirebaseRepository repository;
  late FirebaseMock firebaseAuth;
  final userCredential = UserCredentialMock();
  final user = UserMock();

  setUpAll(() {
    firebaseAuth = FirebaseMock();
    repository = FirebaseRepository(firebaseAuth);
    when(
      () => firebaseAuth.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((invocation) async => userCredential);
    when((() => userCredential.user)).thenReturn(user);
  });

  group('method login', () {
    test('caso de sucesso', () async {
      //act
      final result = await repository.login('jessica@email.com', '123456');
      //assert
      //result.runtimeType == UserModel
      expect(result, isA<UserModel>());
      //result.email == 'jessica@email.com'
      expect(result.email, 'jessica@email.com');
    });
  });

  //sucesso, se logou e devolveu um UserModel
  //erro nao existe o usuario
  //erro conexao com firebase
}
