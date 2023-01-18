import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:t01_firebase_auth/features/home/model/todo.dart';

class CustomDismissible extends StatelessWidget {
  final AsyncValueSetter<String> deleteTodo;
  final TodoModel todoModel;
  const CustomDismissible({Key? key, required this.todoModel, required this.deleteTodo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          await Navigator.of(context).pushNamed(
            '/add-todo',
            arguments: {
              'pageTitle': 'Update todo',
              'todo': todoModel,
              'buttonTitle': 'Update',
            },
          );
          return false;
        } else {
          if (todoModel.id != null) {
            await deleteTodo(todoModel.id!);
            // await controller.deleteTodo(todoModel.id!);
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
      child: ListTile(
        title: Text(todoModel.title),
        subtitle: Text(todoModel.content),
      ),
    );
  }
}
