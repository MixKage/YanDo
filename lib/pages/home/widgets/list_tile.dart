import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yando/model/count_close_tasks.dart';
import 'package:yando/model/task.dart';
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
  final box = Hive.box('yando_tasks');
  late TaskModel _taskModel;
  final int index;

  _MyListTileState(this.index);

  @override
  void initState() {
    _taskModel = TaskModel.fromJson(box.getAt(index));
    super.initState();
  }

  void pressChecked({required bool value}) {
    _taskModel = TaskModel.fromJson(box.getAt(index));
    _taskModel.isChecked = value;
    if (value) {
      Provider.of<CountCloseTasks>(context, listen: false).plusCloseTask();
    } else {
      Provider.of<CountCloseTasks>(context, listen: false).minusCloseTask();
    }
    box.putAt(index, _taskModel.toJson());
  }

  void editTask() {
    NavigationService.instance.pushNamed(NavigationPaths.task, index);
  }

  @override
  Widget build(BuildContext context) => Row(
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
      );
}
