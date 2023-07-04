import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/importance.dart';
import 'package:yando/model/task.dart';
import 'package:yando/model/tasks_notifier.dart';
import 'package:yando/pages/task/widgets/task_widgets.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({required this.task, super.key});

  final TaskModel? task;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  static const double indent = 24;
  Importance _selectedType = Importance.basic;
  late TaskModel task;
  late TextEditingController _textController;
  late DateTime? _dateTime;
  late TasksNotifier tNL;

  @override
  void initState() {
    _textController = TextEditingController();
    initData();
    MyLogger.instance.mes(task.toJson().toString());
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    tNL = Provider.of<TasksNotifier>(context, listen: false);
    super.didChangeDependencies();
  }

  void initData() {
    if (widget.task == null) {
      task = TaskModel.defaultTask();
    } else {
      task = widget.task!;
    }

    _selectedType =
        Importance.values.firstWhere((e) => e.name == task.importance);
    _textController.text = task.text;
    _dateTime = task.deadline;
  }

  void saveTask() {
    task
      ..text = _textController.text
      ..deadline = _dateTime
      ..importance = _selectedType.name;
    if (widget.task == null) {
      tNL.addTask(task);
    } else {
      tNL.updateTask(task);
    }
    Navigator.pop(context);
  }

  void unsaveExit() {
    Navigator.of(context).pop();
  }

  Future<DateTime> selectDateTime() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateTime ?? DateTime.now(),
      firstDate: DateTime(1969, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dateTime) {
      _dateTime = picked;
    }
    return _dateTime ?? DateTime.now();
  }

  void deleteTask() {
    tNL.removeTaskById(task.id);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBarTaskPage(
          unsaveExit: unsaveExit,
          saveTask: saveTask,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldTaskPage(textController: _textController),
                const SizedBox(height: indent),
                ImportantComboBox(
                  selectedType: _selectedType,
                  task: task,
                  onChanged: (value) {
                    _selectedType = value!;
                    task.importance = _selectedType.name;
                    setState(() {});
                  },
                ),
                const SizedBox(height: indent),
                const Divider(color: Colors.grey),
                const SizedBox(height: indent),
                TimePicker(
                  selectData: selectDateTime,
                  offData: () => _dateTime = null,
                  dateTime: _dateTime,
                ),
                const SizedBox(height: indent),
                const Divider(color: Colors.grey),
                const SizedBox(height: indent),
                if (widget.task == null)
                  const SizedBox.shrink()
                else
                  DeleteButton(func: deleteTask),
              ],
            ),
          ),
        ),
      );
}
