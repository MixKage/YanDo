import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/task.dart';
import 'package:yando/pages/task/widgets/delete_button.dart';
import 'package:yando/pages/task/widgets/time_picker.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final List<String> _type = ['Нет', 'Низкий', '!! Высокий'];
  String _selectedType = 'Нет';
  late int? _idTask;
  late Box _box;
  late TaskModel _taskModel;
  late TextEditingController _textController;

  @override
  void initState() {
    _box = Hive.box('yando_tasks');
    _textController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void initData() {
    _idTask = ModalRoute.of(context)?.settings.arguments as int?;
    MyLogger.instance.mes('Изменение задачи ${_idTask ?? _box.length}');
    if (_idTask == null) {
      _idTask = _box.length;
      _taskModel = TaskModel(
        type: 'Нет',
        isChecked: false,
        text: '',
        dateTime: null,
      );
    } else {
      _taskModel = TaskModel.fromJson(_box.getAt(_idTask!));
      _textController.text = _taskModel.text;
      _selectedType = _taskModel.type;
    }
  }

  void saveTask({bool isExit = true}) {
    _taskModel = TaskModel.fromJson(_box.getAt(_idTask!));
    _taskModel
      ..type = _selectedType
      ..text = _textController.text;
    _box.putAt(_idTask!, _taskModel.toJson());
    if (isExit) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    initData();
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
                      saveTask(isExit: false);
                      setState(() {});
                    },
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const Divider(color: Colors.grey),
              const SizedBox(height: 22),
              TimePicker(id: _idTask!),
              const SizedBox(height: 22),
              const Divider(color: Colors.grey),
              const SizedBox(height: 14),
              DeleteButton(id: _idTask!, context: context),
            ],
          ),
        ),
      ),
    );
  }
}
