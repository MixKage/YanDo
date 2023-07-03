import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/importance.dart';
import 'package:yando/model/task.dart';
import 'package:yando/model/tasks_notifier.dart';
import 'package:yando/navigation/nav_service.dart';

class ListTileContent extends StatefulWidget {
  const ListTileContent({
    required this.task,
    super.key,
  });

  final TaskModel task;

  @override
  State<ListTileContent> createState() => _ListTileContentState();
}

class _ListTileContentState extends State<ListTileContent> {
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
  }

  String getDateText(DateTime dateTime) {
    final dateFormat = DateFormat('yyyy-MM-dd');
    return dateFormat.format(dateTime);
  }

  @override
  Widget build(BuildContext context) => Dismissible(
        background: ColoredBox(
          color: Colors.green,
          child: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.done,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
        ),
        secondaryBackground: ColoredBox(
          color: Colors.red,
          child: Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            ),
          ),
        ),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: widget.task.importance ==
                                      Importance.important.name ||
                                  widget.task.importance == Importance.low.name
                              ? 20
                              : 0,
                          child: widget.task.importance ==
                                  Importance.important.name
                              ? const Text(
                                  '!!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )
                              : widget.task.importance == Importance.low.name
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
                                ? const TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                    if (widget.task.deadline == null)
                      const SizedBox()
                    else
                      Text(
                        getDateText(widget.task.deadline!),
                        style: widget.task.done
                            ? const TextStyle(
                                color: Colors.grey,
                              )
                            : null,
                      ),
                  ],
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
