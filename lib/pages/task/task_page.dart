import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/importance.dart';
import 'package:yando/model/task.dart';
import 'package:yando/model/tasks_notifier.dart';
import 'package:yando/navigation/nav_service.dart';
import 'package:yando/pages/task/widgets/task_widgets.dart';
import 'package:yando/theme/theme.dart';

extension on List<Widget> {
  List<Widget> _insertBetweenAll(Widget widget) {
    final result = List<Widget>.empty(growable: true);
    for (int i = 0; i < length; i++) {
      result.add(this[i]);
      if (i != length - 1 && this[i].runtimeType != Divider) {
        result.add(widget);
      }
    }
    return result;
  }
}

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
    MyLogger.i.mes(task.toJson().toString());
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
    NavigationService.i.pop();
  }

  void unsaveExit() {
    NavigationService.i.pop();
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
    NavigationService.i.pop();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBarTaskPage(
          unsaveExit: unsaveExit,
          saveTask: saveTask,
        ),
        body: Padding(
          padding: Theme.of(context).extension<MyExtension>()!.bigEdgeInsets,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldTaskPage(textController: _textController),
                ImportantComboBox(
                  selectedType: _selectedType,
                  task: task,
                  onChanged: (value) {
                    _selectedType = value!;
                    task.importance = _selectedType.name;
                    setState(() {});
                  },
                ),
                Divider(
                  color: Theme.of(context).extension<MyExtension>()!.grey,
                ),
                TimePicker(
                  selectData: selectDateTime,
                  offData: () => _dateTime = null,
                  dateTime: _dateTime,
                ),
                Divider(
                  color: Theme.of(context).extension<MyExtension>()!.grey,
                ),
                if (widget.task == null)
                  const SizedBox.shrink()
                else
                  DeleteButton(func: deleteTask),
              ]._insertBetweenAll(const SizedBox(height: indent)),
            ),
          ),
        ),
      );
}
