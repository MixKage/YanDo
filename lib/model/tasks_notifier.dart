import 'package:flutter/material.dart';
import 'package:yando/database/locale_data.dart';
import 'package:yando/model/task.dart';

class TasksNotifier with ChangeNotifier {
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

  void updateTask(int index, TaskModel taskModel) {
    LocaleData.instance.updateTask(index, taskModel);
    listTasks[index] = taskModel;
    notifyListeners();
  }

  void removeTaskById(int index) {
    LocaleData.instance.removeTaskByid(index);
    listTasks.removeAt(index);
    notifyListeners();
  }
}
