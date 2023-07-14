import 'package:flutter_test/flutter_test.dart';
import 'package:yando/database/local_data.dart';
import 'package:yando/model/task.dart';

Future<void> main() async {
  await LD.i.testInit();

  test(
    'CreateLocaleTask',
    () async {
      final oldTask = TaskModel.defaultWithTextTask('TEST')..id = 9999;
      LD.i.addTask(oldTask);
      final newTask = LD.i.getTaskById(9999);
      expect(oldTask.text, newTask.text);
    },
  );
  test('UpdateLocaleTask', () {
    const String newText = 'NEW_TEXT';
    final oldTask = LD.i.getTaskById(9999)..text = newText;
    LD.i.updateTask(oldTask);
    expect(oldTask.text, newText);
  });
  test('RemoveLocaleTask', () async {
    await LD.i.deleteAll();
    TaskModel? task;
    try {
      task = LD.i.getTaskById(9999);
    } on Exception catch (_) {
      task = null;
    }
    expect(task, null);
  });
}
