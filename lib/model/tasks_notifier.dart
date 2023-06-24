import 'package:flutter/material.dart';
import 'package:yando/database/locale_data.dart';
import 'package:yando/internet/internet_service.dart';
import 'package:yando/model/task.dart';

class TasksNotifier extends ChangeNotifier {
  List<TaskModel> listTasks;
  List<TaskModel> listCloseTasks = [];

  int get countCloseTask => listTasks.fold(0, (t, e) => t + (e.done ? 1 : 0));

  TasksNotifier(this.listTasks);

  factory TasksNotifier.fromHive() =>
      TasksNotifier(LocaleData.instance.getListTasks());

  Future<void> addTask(TaskModel taskModel) async {
    LocaleData.instance.addTask(taskModel);
    listTasks.add(taskModel);
    if (taskModel.id != -1) {
      await IS.instance.createTask(taskModel);
    }

    notifyListeners();
  }

  Future<void> updateTask(TaskModel taskModel) async {
    taskModel
      ..changedAt = DateTime.now()
      // TODO: CHANGE_IT ON UNIQ ID DEVICE
      ..lastUpdatedBy = '';
    if (taskModel.id == -1) {
      await IS.instance.createTask(taskModel);
    } else {
      await IS.instance.updateTaskById(taskModel);
    }
    final index = LocaleData.instance.updateTask(taskModel);
    listTasks[index] = taskModel;
    notifyListeners();
  }

  Future<void> removeTaskById(int id) async {
    final index = LocaleData.instance.removeTaskById(id);
    listTasks.removeAt(index);
    await IS.instance.deleteById(id);
    notifyListeners();
  }

  void hideDoneList({required bool isVisible}) {
    for (int i = 0; i < listTasks.length; i++) {
      if (!isVisible) {
        if (listTasks[i].done) {
          listCloseTasks.add(listTasks[i]);
          listTasks.removeAt(i);
        }
      } else {
        for (int i = 0; i < listCloseTasks.length; i++) {
          listTasks.add(listCloseTasks[i]);
          listCloseTasks.removeAt(i);
        }
      }
    }
    notifyListeners();
  }

  Future<void> getFromServer() async {
    final taskModels = await IS.instance.getAll();
    if (taskModels != null) {
      listTasks = List.from(taskModels);
    }
    await LocaleData.instance.deleteAll();
    for (int i = 0; i < listTasks.length; i++) {
      LocaleData.instance.addTask(listTasks[i]);
    }
    notifyListeners();
  }

  Future<void> syncList() async {
    final syncList = await IS.instance.updateAll(listTasks);
    listTasks = syncList == null ? [] : List.from(syncList);
    notifyListeners();
  }

  void deleteAll() {
    listTasks.clear();
    listCloseTasks.clear();
    LocaleData.instance.deleteAll();
  }
}
