import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/importance.dart';
import 'package:yando/model/task.dart';
import 'package:yando/model/tasks_notifier.dart';
import 'package:yando/pages/task/widgets/delete_button.dart';
import 'package:yando/pages/task/widgets/time_picker.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({required this.task, super.key});

  final TaskModel? task;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  Importance _selectedType = Importance.basic;
  late TextEditingController _textController;
  late DateTime? _dateTime;

  @override
  void initState() {
    _textController = TextEditingController();
    initData();
    MyLogger.instance.mes(widget.task!.toJson().toString());
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void initData() {
    _selectedType =
        Importance.values.firstWhere((e) => e.name == widget.task!.importance);
    _textController.text = widget.task!.text;
    _dateTime = widget.task!.deadline;
  }

  void saveTask() {
    widget.task!
      ..text = _textController.text
      ..deadline = _dateTime
      ..importance = _selectedType.name;

    Provider.of<TasksNotifier>(context, listen: false).updateTask(widget.task!);
    Navigator.pop(context);
  }

  Future<DateTime> selectDateTime() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTime ?? DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dateTime) {
      _dateTime = picked;
    }
    return _dateTime ?? DateTime.now();
  }

  void deleteTask() {
    Provider.of<TasksNotifier>(context, listen: false)
        .removeTaskById(widget.task!.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: Navigator.of(context).pop,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.clear,
                  color: Theme.of(context).secondaryHeaderColor,
                ),
              ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.black12),
                ),
                onPressed: saveTask,
                child: Text(
                  'сохранить',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(8),
                  child: TextField(
                    controller: _textController,
                    minLines: 4,
                    maxLines: 100,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: const InputDecoration(
                      hintText: 'Что-то надо сделать...',
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Важность',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    DropdownButton<Importance>(
                      iconSize: 0.0,
                      underline: const SizedBox(),
                      value: _selectedType,
                      items: Importance.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  e.name == Importance.important.name
                                      ? '!! ${e.lvl}'
                                      : e.lvl,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: e == Importance.important
                                        ? Colors.red
                                        : Theme.of(context)
                                            .secondaryHeaderColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        _selectedType = value!;
                        widget.task!.importance = _selectedType.name;
                        setState(() {});
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 22),
                const Divider(color: Colors.grey),
                const SizedBox(height: 22),
                TimePicker(
                  selectData: selectDateTime,
                  offData: () {
                    _dateTime = null;
                  },
                  dateTime: _dateTime,
                ),
                const SizedBox(height: 22),
                const Divider(color: Colors.grey),
                const SizedBox(height: 14),
                if (widget.task!.id == -1)
                  const SizedBox()
                else
                  DeleteButton(func: deleteTask),
              ],
            ),
          ),
        ),
      );
}
