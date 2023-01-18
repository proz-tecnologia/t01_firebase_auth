import 'package:flutter/material.dart';
import 'package:t01_firebase_auth/features/home/home_controller.dart';
import 'package:t01_firebase_auth/features/home/home_state.dart';
import 'package:t01_firebase_auth/shared/injection.dart';

import 'widgets/custom_dismissible.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //injetamos o controller no getIt pra conseguir mockar no teste
  final controller = getIt.get<HomeController>();
  String? title;
  @override
  void initState() {
    super.initState();
    controller.notifier.addListener(() {
      if (controller.state is HomeLogoutState) {
        Navigator.of(context).pushNamedAndRemoveUntil('/signin', (route) => false);
      }
    });
    controller.getTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: ValueListenableBuilder(
          valueListenable: controller.notifier,
          builder: (context, state, _) {
            if (state is HomeLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is HomeErrorState) {
              return Center(
                child: TextButton(
                  child: const Text('Tentar Novamente'),
                  onPressed: () async {
                    await controller.getTodo();
                  },
                ),
              );
            }
            if (state is HomeEmptyState) {
              return Center(
                child: TextButton(
                  child: const Text('Tem nada aqui parça'),
                  onPressed: () async {
                    await controller.getTodo();
                  },
                ),
              );
            }
            if (state is HomeSuccessState) {
              return Center(
                child: ListView.builder(
                  itemCount: state.todoList.length,
                  itemBuilder: (context, index) {
                    final todo = state.todoList[index];
                    return CustomDismissible(
                      todoModel: todo,
                      deleteTodo: (value) => controller.deleteTodo(value),
                    );
                  },
                ),
              );
            } //
            return const SizedBox.shrink();
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).pushNamed(
            '/add-todo',
            arguments: {'pageTitle': 'Add todo'},
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
