import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({required this.id, required this.context, super.key});

  final BuildContext context;
  final int id;

  void _deleteTask() {
    final box = Hive.box('yando_tasks');
    box.deleteAt(id);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: _deleteTask,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
              Text(
                'Удалить',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      );
}
