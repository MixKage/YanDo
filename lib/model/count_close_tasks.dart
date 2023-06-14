import 'package:flutter/material.dart';

class CountCloseTasks extends ChangeNotifier {
  int countCloseTask = 0;

  void plusCloseTask() {
    countCloseTask++;
    notifyListeners();
  }

  void minusCloseTask() {
    countCloseTask--;
    notifyListeners();
  }
}
