import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:t01_firebase_auth/features/home/home_firebase_repository.dart';

void main() {
  late HomeFirebaseRepository homeFirebaseRepository;
  late FakeFirebaseFirestore firestoreMock;

  setUp(() {
    firestoreMock = FakeFirebaseFirestore();
    homeFirebaseRepository = HomeFirebaseRepository(firestoreMock);
  });

  group('getTodo', () {
    //se primeiro acesso, devolver lista vazia
    test('empty', () async {
      final result = await homeFirebaseRepository.getTodo('');
      expect(result, isEmpty);
    });

    //se tiver algo, devolver uma lista de todomodel
    test('com algum valor', () async {
      await firestoreMock.collection('todoList').add(
        {
          'content': 'Bob',
          'date': 123,
          'title': 'title',
          'userId': 'userId',
        },
      );
      final result = await homeFirebaseRepository.getTodo('userId');
      expect(result.length, 1);
      expect(result[0].date, DateTime.fromMillisecondsSinceEpoch(123));
    });
  });
}
