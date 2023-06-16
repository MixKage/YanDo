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
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  late TaskModel _taskModel;

  @override
  void initState() {
    _taskModel = LocaleData.instance.getTaskById(widget.index);
    super.initState();
  }

  void pressChecked({required bool value}) {
    _taskModel.isChecked = value;

    if (value) {
      MyLogger.instance.mes('Checked ${widget.index} task');
    } else {
      MyLogger.instance.mes('Unchecked ${widget.index} task');
    }
    Provider.of<TasksNotifier>(context, listen: false)
        .updateTask(widget.index, _taskModel);
  }

  Future<void> editTask() async {
    MyLogger.instance.mes('Start edite ${widget.index} task');
    await NavigationService.instance
        .pushNamed(NavigationPaths.task, widget.index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) => Dismissible(
        background: Container(color: Colors.green),
        secondaryBackground: Container(color: const Color(0xFFFF3B30)),
        key: ValueKey<int>(widget.index),
        onDismissed: (DismissDirection direction) {
          if (direction == DismissDirection.endToStart) {
            _taskModel.isChecked = !_taskModel.isChecked;
            Provider.of<TasksNotifier>(context, listen: false)
                .updateTask(widget.index, _taskModel);
          }
        },
        onUpdate: (DismissUpdateDetails direction) {
          if (direction.direction == DismissDirection.startToEnd &&
              direction.progress > 0.5) {}
        },
        confirmDismiss: (DismissDirection direction) async {
          if (direction == DismissDirection.startToEnd) {
            return false;
          } else {
            return true;
          }
        },
        child: Container(
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
              SizedBox(
                  width: _taskModel.type == '!! Высокий' ||
                          _taskModel.type == 'Низкий'
                      ? 20
                      : 0,
                  child: _taskModel.type == '!! Высокий'
                      ? const Text(
                          '!!',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )
                      : _taskModel.type == 'Низкий'
                          ? const Icon(
                              Icons.arrow_downward_outlined,
                              size: 18,
                            )
                          : null),
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
        ),
      );
}
