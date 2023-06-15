import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yando/database/locale_data.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/task.dart';
import 'package:yando/model/tasks_notifier.dart';
import 'package:yando/navigation/nav_service.dart';

class MyListTile extends StatefulWidget {
  const MyListTile({
    required this.index,
    super.key,
  });

  final int index;

  @override
  // ignore: no_logic_in_create_state
  State<MyListTile> createState() => _MyListTileState(index);
}

class _MyListTileState extends State<MyListTile> {
  late TaskModel _taskModel;
  final int index;

  _MyListTileState(this.index);

  @override
  void initState() {
    _taskModel = LocaleData.instance.getTaskById(index);
    super.initState();
  }

  void pressChecked({required bool value}) {
    _taskModel.isChecked = value;

    if (value) {
      MyLogger.instance.mes('Checked $index task');
    } else {
      MyLogger.instance.mes('Unchecked $index task');
    }
    Provider.of<TasksNotifier>(context, listen: false)
        .updateTask(index, _taskModel);
  }

  Future<void> editTask() async {
    MyLogger.instance.mes('Start edite $index task');
    await NavigationService.instance.pushNamed(NavigationPaths.task, index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          children: [
            Checkbox(
              activeColor: Colors.green,
              value: _taskModel.isChecked,
              onChanged: (value) {
                setState(() {
                  pressChecked(value: value!);
                });
              },
            ),
            Expanded(
              child: Text(
                _taskModel.text,
                style: _taskModel.isChecked
                    ? const TextStyle(decoration: TextDecoration.lineThrough)
                    : null,
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: editTask,
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.info_outline,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
