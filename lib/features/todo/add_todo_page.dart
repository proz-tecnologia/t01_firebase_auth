import 'package:flutter/material.dart';
import 'package:t01_firebase_auth/features/home/model/todo.dart';
import 'package:t01_firebase_auth/features/sign_in/sign_in_repository.dart';
import 'package:t01_firebase_auth/features/todo/add_todo_controller.dart';
import 'package:t01_firebase_auth/shared/injection.dart';

import 'add_todo_repository.dart';
import 'add_todo_state.dart';

class AddTodoPage extends StatefulWidget {
  final TodoModel? todo;
  final String pageTitle;
  final String? buttonTitle;

  const AddTodoPage({
    Key? key,
    required this.pageTitle,
    this.todo,
    this.buttonTitle,
  }) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final controller = AddTodoController(
    getIt.get<AuthRepository>(),
    AddTodoRepository(),
  );
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.todo?.title ?? '';
    contentController.text = widget.todo?.content ?? '';
    controller.notifier.addListener(() {
      if (controller.state is AddTodoSuccessState) {
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.pageTitle),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: titleController,
              ),
              TextFormField(
                controller: contentController,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (widget.todo == null) {
                    await controller.addTodo(titleController.text, contentController.text);
                  } else {
                    await controller.updateTodo(widget.todo!, titleController.text, contentController.text);
                  }
                },
                child: Text(widget.buttonTitle ?? 'Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
