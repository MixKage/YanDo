import 'package:hive_flutter/hive_flutter.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/task.dart';

// Работа с базой данных
class LocaleData {
  LocaleData._();

  static LocaleData instance = LocaleData._();

  factory LocaleData() => instance;

  late Box _box;

  int get length => _box.length;

  Future<void> initAsync() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('yando_tasks');
  }

  void addTask(TaskModel taskModel) {
    MyLogger.instance.mes('Create Task'
        '${taskModel.toJson()}');
    _box.add(taskModel.toJson());
  }

  void updateTask(int index, TaskModel taskModel) {
    MyLogger.instance.mes('Update Task '
        '$index ${taskModel.toJson()}');
    _box.putAt(index, taskModel.toJson());
  }

  TaskModel getTaskById(int index) {
    MyLogger.instance.mes('Get Task by id '
        '$index');
    return TaskModel.fromJson(_box.getAt(index));
  }

  void removeTaskByid(int index) {
    MyLogger.instance.mes('Removed task by id '
        '$index');
    _box.deleteAt(index);
  }

  void deleteAll() {
    _box.clear();
  }
}
