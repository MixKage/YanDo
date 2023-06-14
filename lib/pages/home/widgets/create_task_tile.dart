import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/task.dart';

class CreateTaskTile extends StatefulWidget {
  const CreateTaskTile({super.key});

  @override
  State<CreateTaskTile> createState() => _CreateTaskTileState();
}

class _CreateTaskTileState extends State<CreateTaskTile> {
  void createTask(String text) {
    MyLogger.instance.mes('Create Task $text');
    final box = Hive.box('yando_tasks');
    final newTask = TaskModel(
      type: 'Нет',
      isChecked: false,
      text: text,
      dateTime: null,
    ).toJson();
    box.add(newTask);
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
          },
        ),
      );
}
