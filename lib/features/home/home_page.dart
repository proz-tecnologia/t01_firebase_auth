import 'package:flutter/material.dart';
import 'package:t01_firebase_auth/features/home/home_controller.dart';
import 'package:t01_firebase_auth/features/home/home_firebase_repository.dart';
import 'package:t01_firebase_auth/features/home/home_state.dart';
import 'package:t01_firebase_auth/features/sign_in/sign_in_repository.dart';
import 'package:t01_firebase_auth/shared/injection.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final controller = HomeController(getIt.get<AuthRepository>(), HomeFirebaseRepository());

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
            if (state is HomeSuccessState) {
              return Center(
                child: ListView.builder(
                  itemCount: state.todoList.length,
                  itemBuilder: (context, index) {
                    final todo = state.todoList[index];
                    return Dismissible(
                      confirmDismiss: (direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          await Navigator.of(context).pushNamed(
                            '/add-todo',
                            arguments: {
                              'pageTitle': 'Update todo',
                              'todo': todo,
                              'buttonTitle': 'Update',
                            },
                          );
                          return false;
                        } else {
                          if (todo.id != null) {
                            await controller.deleteTodo(todo.id!);
                          }
                          return true;
                        }
                      },
                      key: UniqueKey(),
                      background: Container(
                        padding: const EdgeInsets.only(left: 8),
                        alignment: Alignment.centerLeft,
                        color: Colors.green,
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                      secondaryBackground: Container(
                        padding: const EdgeInsets.only(right: 8),
                        alignment: Alignment.centerRight,
                        color: Colors.red,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      // onDismissed: (direction) {
                      //   if (direction == DismissDirection.startToEnd) {
                      //     Navigator.of(context).pushNamed(
                      //       '/add-todo',
                      //       arguments: {
                      //         'pageTitle': 'Update todo',
                      //         'todoTitle': todo.title,
                      //         'todoContent': todo.content,
                      //       },
                      //     );
                      //   }
                      // },
                      child: ListTile(
                        title: Text(todo.title),
                        subtitle: Text(todo.content),
                      ),
                    );
                    // ExpansionTile(
                    //   expandedAlignment: Alignment.centerLeft,
                    //   title: Row(
                    //     children: [
                    //       Text(todo.title),
                    //       const SizedBox(width: 8),
                    //       Text(todo.date.formattedDate),
                    //     ],
                    //   ),
                    //   children: [
                    //     Row(
                    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //       children: [
                    //         Padding(
                    //           padding: const EdgeInsets.all(16),
                    //           child: Text(todo.content),
                    //         ),
                    //         const Spacer(),
                    //         IconButton(
                    //           onPressed: () {},
                    //           icon: const Icon(Icons.edit),
                    //           splashRadius: 24,
                    //         ),
                    //         IconButton(
                    //           onPressed: () {
                    //             // if (todo.id != null) {
                    //             //   controller.deleteTodo(todo.id!);
                    //             // }
                    //           },
                    //           icon: const Icon(Icons.delete),
                    //         ),
                    //       ],
                    //     )
                    //   ],
                    // );
                  },
                ),
              );
            }
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
