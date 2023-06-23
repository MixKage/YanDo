import 'package:flutter/material.dart';
import 'package:yando/database/locale_data.dart';
import 'package:yando/model/task.dart';

class TasksNotifier extends ChangeNotifier {
  final List<TaskModel> listTasks;
  List<TaskModel> listCloseTasks = [];

  TasksNotifier(this.listTasks);

  factory TasksNotifier.fromHive() =>
      TasksNotifier(LocaleData.instance.getListTasks());

  void addTask(TaskModel taskModel) {
    LocaleData.instance.addTask(taskModel);
    listTasks.add(taskModel);
    notifyListeners();
  }

  void updateTask(TaskModel taskModel) {
    taskModel
      ..changedAt = DateTime.now()
      // TODO: CHANGE_IT ON UNIQ ID DEVICE
      ..lastUpdatedBy = '';
    final index = LocaleData.instance.updateTask(taskModel);
    listTasks[index] = taskModel;
    notifyListeners();
  }

  void removeTaskById(int id) {
    final index = LocaleData.instance.removeTaskById(id);
    listTasks.removeAt(index);
    notifyListeners();
  }
}
