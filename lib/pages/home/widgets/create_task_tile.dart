import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/task.dart';
import 'package:yando/model/tasks_notifier.dart';

class CreateTaskTile extends StatefulWidget {
  const CreateTaskTile({super.key});

  @override
  State<CreateTaskTile> createState() => _CreateTaskTileState();
}

class _CreateTaskTileState extends State<CreateTaskTile> {
  void createTask(String text) {
    MyLogger.instance.mes('Create Task $text');
    final newTask = TaskModel.defaultWithTextTask(text);
    Provider.of<TasksNotifier>(context, listen: false).addTask(newTask);
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 42),
        child: TextField(
          decoration: const InputDecoration(
            hintText: 'Что-то надо сделать...',
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) createTask(value);
            MyLogger.instance.mes('Create defaultWithTextTask');
          },
        ),
      );
}
