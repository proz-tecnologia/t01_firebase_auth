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
  late UserCredentialMock userCredential;
  late UserMock user;

  setUp(() {
    firebaseAuth = FirebaseMock();
    repository = FirebaseRepository(firebaseAuth);
    userCredential = UserCredentialMock();
    user = UserMock();
  });

  group('login', () {
    //sucesso, se logou e devolveu um UserModel
    test('caso de sucesso', () async {
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((invocation) async => userCredential);
      when((() => userCredential.user)).thenReturn(user);
      //act
      final result = await repository.login('jessica@email.com', '123456');
      //assert
      //result.runtimeType == UserModel
      expect(result, isA<UserModel>());
      //result.email == 'jessica@email.com'
      expect(result.email, 'jessica@email.com');
    });

    //erro nao existe o usuario
    test('se nao vier user, throw exception', () async {
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((invocation) async => userCredential);
      //act
      //assert
      expect(() => repository.login('jessica@email.com', '123456'), throwsA(isA<Exception>()));
    });

    //erro conexao com firebase
    test('se nao tiver conexão, throw exception', () async {
      when(
        () => firebaseAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(Exception());
      //act
      //assert
      expect(() => repository.login('jessica@email.com', '123456'), throwsException);
    });
  });
}
