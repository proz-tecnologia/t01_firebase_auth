import 'package:flutter/material.dart';
import 'package:t01_firebase_auth/features/sign_in/sign_in_repository.dart';
import 'package:t01_firebase_auth/features/todo/add_todo_controller.dart';
import 'package:t01_firebase_auth/shared/injection.dart';

import 'add_todo_repository.dart';
import 'add_todo_state.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

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
    controller.notifier.addListener(() { 
      if(controller.state is AddTodoSuccessState){
        Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
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
                  await controller.addTodo(titleController.text, contentController.text);
                },
                child: const Text('Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
