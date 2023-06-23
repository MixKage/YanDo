import 'dart:math';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/task.dart';

class LocaleData {
  LocaleData._();

  static LocaleData instance = LocaleData._();

  factory LocaleData() => instance;

  late Box _box;
  late String deviceId;

  int get newId => _box.values.map((e) => TaskModel.fromJson(e).id).reduce(max);

  int get length => _box.length;

  Future<void> initAsync() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('yando_tasks');
    // final deviceInfoPlugin = DeviceInfoPlugin();
    // final deviceInfo = await deviceInfoPlugin.deviceInfo;
    // final allInfo = deviceInfo.data;
    // print(allInfo);
    deviceId = '';
    //deviceId = deviceInfo.data;
  }

  void addTask(TaskModel taskModel) {
    MyLogger.instance.mes('Create Task'
        '${taskModel.toJson()}');
    _box.add(taskModel.toJson());
  }

  int updateTask(TaskModel taskModel) {
    MyLogger.instance.mes('Update Task '
        '${taskModel.id} ${taskModel.toJson()}');
    for (int i = 0; i < length; i++) {
      if (TaskModel.fromJson(_box.getAt(i)).id == taskModel.id) {
        _box.put(taskModel.id, taskModel.toJson());
        return i;
      }
    }
    MyLogger.instance.err('Undefined task by id ${taskModel.id}');
    throw Exception('Undefined task by id ${taskModel.id}');
  }

  TaskModel getTaskById(int id) {
    MyLogger.instance.mes('Get Task by id '
        '$id');
    for (int i = 0; i < length; i++) {
      if (TaskModel.fromJson(_box.getAt(i)).id == id) {
        return TaskModel.fromJson(_box.getAt(i));
      }
    }
    MyLogger.instance.err('Undefined task by id $id');
    throw Exception('Undefined task by id $id');
  }

  int removeTaskById(int id) {
    MyLogger.instance.mes('Removed task by id '
        '$id');
    for (int i = 0; i < length; i++) {
      if (TaskModel.fromJson(_box.getAt(i)).id == id) {
        _box.deleteAt(i);
        return i;
      }
    }
    MyLogger.instance.err('Undefined task by id $id');
    throw Exception('Undefined task by id $id');
  }

  List<TaskModel> getListTasks() =>
      _box.values.map((e) => TaskModel.fromJson(e)).toList();

  void deleteAll() {
    _box.clear();
  }
}
