import 'package:flutter/material.dart';
import 'package:yando/database/local_data.dart';
import 'package:yando/internet/internet_service.dart';
import 'package:yando/model/task.dart';

class TasksNotifier extends ChangeNotifier {
  List<TaskModel> listTasks;

  // listTasks.where((task) => task.done).toList().size
  int get countCloseTask => listTasks.fold(0, (t, e) => t + (e.done ? 1 : 0));
  bool _visibility = false;

  bool get visibility => _visibility;

  set visibility(bool val) {
    _visibility = val;
    notifyListeners();
  }

  TasksNotifier(this.listTasks);

  factory TasksNotifier.fromHive() => TasksNotifier(LD.instance.getListTasks());

  Future<void> addTask(TaskModel taskModel) async {
    LD.instance.addTask(taskModel);
    await IS.instance.createTask(taskModel);
    listTasks.add(taskModel);
    notifyListeners();
  }

  Future<void> updateTask(TaskModel taskModel) async {
    taskModel
      ..changedAt = DateTime.now()
      ..lastUpdatedBy = LD.instance.idDevice;

    await IS.instance.updateTaskById(taskModel);
    final index = LD.instance.updateTask(taskModel);
    listTasks[index] = taskModel;
    notifyListeners();
  }

  Future<void> removeTaskById(int id) async {
    final index = LD.instance.removeTaskById(id);
    listTasks.removeAt(index);
    await IS.instance.deleteById(id);
    notifyListeners();
  }

  Future<void> getFromServer() async {
    //final tasks = await IS.instance.getAll();

    listTasks = await IS.instance.updateAll(LD.instance.getListTasks()) ?? [];

    // if (taskModels != null) {
    //   listTasks = List.from(taskModels);
    // }
    // await LD.instance.deleteAll();
    // for (int i = 0; i < listTasks.length; i++) {
    //   LD.instance.addTask(listTasks[i]);
    // }
    notifyListeners();
  }

  // Синхронизирует локальные с облачнными данными.
  // Обновляет таски взависимости от времени последнего
  // изменения. Таски созданные на другом устройстве
  // не будут удалены.
  Future<void> syncList() async {
    final sList = await IS.instance.getAll();
    final lList = LD.instance.getListTasks();
    final List<TaskModel> result = [];

    if (sList == null) {
      await IS.instance.updateAll(listTasks);
      listTasks = List.from(lList);
      notifyListeners();
      return;
    }

    for (int i = 0; i < sList.length; i++) {
      bool isRepeat = false;
      for (int j = 0; j < lList.length; j++) {
        if (sList[i].id == lList[j].id) {
          isRepeat = true;
          break;
        }
      }
      if (!isRepeat) {
        result.add(sList[i]);
        isRepeat = false;
      }
    }

    for (int i = 0; i < result.length; i++) {
      lList.add(result[i]);
    }

    final syncList = await IS.instance.updateAll(lList);
    listTasks = syncList == null ? [] : List.from(syncList);
    notifyListeners();
  }

  void deleteAll() {
    listTasks.clear();
    LD.instance.deleteAll();
  }
}
