import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/task.dart';
import 'package:yando/model/tasks_notifier.dart';
import 'package:yando/navigation/nav_service.dart';

class MyListTile extends StatefulWidget {
  const MyListTile({
    required this.task,
    super.key,
  });

  final TaskModel task;

  @override
  State<MyListTile> createState() => _MyListTileState();
}

class _MyListTileState extends State<MyListTile> {
  @override
  void initState() {
    super.initState();
  }

  void pressChecked({required bool value}) {
    widget.task.done = value;

    if (value) {
      MyLogger.instance.mes('Checked ${widget.task.id} task');
    } else {
      MyLogger.instance.mes('Unchecked ${widget.task.id} task');
    }
    Provider.of<TasksNotifier>(context, listen: false).updateTask(widget.task);
  }

  Future<void> editTask() async {
    MyLogger.instance.mes('Start edite ${widget.task.id} task');
    await NavigationService.instance
        .pushNamed(NavigationPaths.task, widget.task);
    // TODO: CHEK_IT
    // setState(() {});
  }

  @override
  Widget build(BuildContext context) => Dismissible(
        background: Container(color: Colors.green),
        secondaryBackground: Container(color: const Color(0xFFFF3B30)),
        key: ValueKey<int>(widget.task.id),
        confirmDismiss: (DismissDirection direction) async {
          if (direction == DismissDirection.startToEnd) {
            widget.task.done = !widget.task.done;
            Provider.of<TasksNotifier>(context, listen: false)
                .updateTask(widget.task);
            return false;
          } else if (direction == DismissDirection.endToStart) {
            Provider.of<TasksNotifier>(context, listen: false)
                .removeTaskById(widget.task.id);
            return true;
          }
          return null;
        },
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Theme.of(context).cardColor,
          ),
          child: Row(
            children: [
              Checkbox(
                activeColor: Colors.green,
                value: widget.task.done,
                onChanged: (value) {
                  setState(() {
                    pressChecked(value: value!);
                  });
                },
              ),
              // TODO: CHANGE_IT ON ENUM
              SizedBox(
                width: widget.task.importance == '!! Высокий' ||
                        widget.task.importance == 'Низкий'
                    ? 20
                    : 0,
                child: widget.task.importance == '!! Высокий'
                    ? const Text(
                        '!!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    : widget.task.importance == 'Низкий'
                        ? const Icon(
                            Icons.arrow_downward_outlined,
                            size: 18,
                          )
                        : null,
              ),
              Expanded(
                child: Text(
                  widget.task.text,
                  style: widget.task.done
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
