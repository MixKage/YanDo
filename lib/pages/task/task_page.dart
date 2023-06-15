import 'package:flutter/material.dart';
import 'package:yando/database/locale_data.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/task.dart';
import 'package:yando/pages/task/widgets/delete_button.dart';
import 'package:yando/pages/task/widgets/time_picker.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({required this.taskId, super.key});

  final int? taskId;

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<String> _type = ['Нет', 'Низкий', '!! Высокий'];
  String _selectedType = 'Нет';
  late final int _idTask;
  late TaskModel _taskModel;
  late TextEditingController _textController;
  late DateTime? _dateTime;

  @override
  void initState() {
    _textController = TextEditingController();
    if (widget.taskId == null) {
      _idTask = LocaleData.instance.length;
      _taskModel = TaskModel.defaultTask();
    } else {
      _idTask = widget.taskId!.toInt();
      _taskModel = LocaleData.instance.getTaskById(_idTask);
    }
    initData();
    MyLogger.instance.mes(_taskModel.toJson().toString());
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void initData() {
    _selectedType = _taskModel.type;
    _textController.text = _taskModel.text;
    _dateTime = _taskModel.dateTime;
  }

  void saveTask() {
    _taskModel.text = _textController.text;
    _taskModel.dateTime = _dateTime;
    _taskModel.type = _selectedType;
    if (widget.taskId == null) {
      LocaleData.instance.addTask(_taskModel);
    } else {
      LocaleData.instance.updateTask(_idTask, _taskModel);
    }
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
    LocaleData.instance.removeTaskByid(_idTask);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  DropdownButton(
                    iconSize: 0.0,
                    underline: const SizedBox(),
                    value: _selectedType,
                    items: _type
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: e == '!! Высокий'
                                      ? Colors.red
                                      : Theme.of(context).secondaryHeaderColor,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      _selectedType = value.toString();
                      _taskModel.type = _selectedType;
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
              widget.taskId == null
                  ? const SizedBox()
                  : DeleteButton(func: deleteTask),
            ],
          ),
        ),
      ),
    );
  }
}
