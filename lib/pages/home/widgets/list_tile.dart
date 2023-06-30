import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yando/model/task.dart';
import 'package:yando/model/tasks_notifier.dart';
import 'package:yando/pages/home/widgets/list_tile_content.dart';

class ListTile extends StatelessWidget {
  const ListTile({required this.task, super.key});

  final TaskModel task;

  @override
  Widget build(BuildContext context) => AnimatedCrossFade(
        key: ValueKey<int>(task.id),
        firstChild: ListTileContent(
          task: task,
        ),
        secondChild: const SizedBox(),
        crossFadeState:
            Provider.of<TasksNotifier>(context).visibility && task.done
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
        sizeCurve: Curves.easeInOutQuad,
        duration: const Duration(milliseconds: 500),
      );
}
