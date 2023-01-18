import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:t01_firebase_auth/features/home/home_controller.dart';
import 'package:t01_firebase_auth/features/home/home_page.dart';
import 'package:t01_firebase_auth/features/home/home_state.dart';

class HomeControllerMock extends Mock implements HomeController {}

void main() {
  final controller = HomeControllerMock();
  final getIt = GetIt.instance;
  //mock do state usado no controller
  final notifier = ValueNotifier<HomeState>(HomeInitialState());

  setUp(() {
    getIt.registerSingleton<HomeController>(controller);
  });

  testWidgets('HomePage', (tester) async {
    //stub do método get notifier do controller
    when(() => controller.notifier).thenReturn(notifier);
    //stub da função getTodo do controller
    when(() => controller.getTodo()).thenAnswer((invocation) async {});

    //renderiza a page
    await tester.pumpWidget(const MaterialApp(home: MyHomePage(title: 'teste')));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);

    //stub do state do controller, usado na linha 24 da home page
    when(() => controller.state).thenReturn(notifier.value);

    //altera o estado pra loading, no mock local do teste
    notifier.value = HomeLoadingState();

    //esse cara pula um frame e trava a tela
    //assim ele para o CircularProgress
    //se usarmos o pumpAndSettle o CircularProgress não para de rodar, não conclui o teste
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    expect(find.byType(TextButton), findsNothing);
  });
}
