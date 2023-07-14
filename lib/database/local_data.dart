import 'dart:io';
import 'dart:math';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/task.dart';

class LD {
  LD._();

  static LD i = LD._();

  factory LD() => i;

  late Box _box;
  late Box _appInfo;

  int get newId => _box.length == 0
      ? 0
      : _box.values.map((e) => TaskModel.fromJson(e).id).reduce(max) + 1;

  int get length => _box.length;

  int get revision => _appInfo.get('revision', defaultValue: 0);

  set revision(int r) => _appInfo.put('revision', r);

  String get idDevice => _appInfo.get('uniq_id', defaultValue: '');

  set idDevice(String id) => _appInfo.put('uniq_id', id);

  Future<String> _getId() async {
    final deviceInfo = DeviceInfoPlugin();
    if (kIsWeb) {
      return 'Not found UNIQ ID is Browser';
    } else {
      if (Platform.isIOS) {
        return (await deviceInfo.iosInfo).identifierForVendor ??
            'Not found IOS ID';
      } else if (Platform.isAndroid) {
        return (await deviceInfo.androidInfo).id;
      } else {
        return 'Not found UNIQ ID';
      }
    }
  }

  Future<void> initAsync() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('yando_tasks');
    _appInfo = await Hive.openBox('app_info');
    if (idDevice == '') {
      idDevice = await _getId();
    }
  }

  Future<void> testInit() async {
    final path = Directory.current.path;
    Hive.init('$path/test/hive_testing_path');
    _box = await Hive.openBox('yando_tasks');
    _appInfo = await Hive.openBox('app_info');
  }

  void addTask(TaskModel taskModel) {
    MyLogger.i.mes('Create Task'
        '${taskModel.toJson()}');
    _box.add(taskModel.toJson());
  }

  int updateTask(TaskModel taskModel) {
    MyLogger.i.mes('Update Task '
        '${taskModel.id} ${taskModel.toJson()}');
    for (int i = 0; i < length; i++) {
      if (TaskModel.fromJson(_box.getAt(i)).id == taskModel.id) {
        _box.put(taskModel.id, taskModel.toJson());
        return i;
      }
    }
    MyLogger.i.err('Undefined task by id ${taskModel.id}');
    throw Exception('Undefined task by id ${taskModel.id}');
  }

  TaskModel getTaskById(int id) {
    MyLogger.i.mes('Get Task by id '
        '$id');

    for (int i = 0; i < length; i++) {
      if (TaskModel.fromJson(_box.getAt(i)).id == id) {
        return TaskModel.fromJson(_box.getAt(i));
      }
    }
    MyLogger.i.err('Undefined task by id $id');
    throw Exception('Undefined task by id $id');

    // in future rewrite on this style
    // return _box.values
    //           .map(
    //             (e) =>
    //         TaskModel
    //             .fromJson(e)
    //             .id == id
    //             ? TaskModel.fromJson(e)
    //             : throw Exception('Undefined task by id $id'),
    //       )
  }

  int removeTaskById(int id) {
    MyLogger.i.mes('Removed task by id '
        '$id');
    for (int i = 0; i < length; i++) {
      if (TaskModel.fromJson(_box.getAt(i)).id == id) {
        MyLogger.i.mes('Deleted task by id $id');
        _box.deleteAt(i);
        return i;
      }
    }
    MyLogger.i.err('Undefined task by id $id');
    throw Exception('Undefined task by id $id');
  }

  List<TaskModel> getListTasks() =>
      _box.values.map((e) => TaskModel.fromJson(e)).toList();

  Future<void> deleteAll() => _box.clear();
}
