import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:yando/model/task.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({required this.id, super.key});

  final int id;

  @override
  // ignore: no_logic_in_create_state
  State<TimePicker> createState() => _TimePickerState(id);
}

class _TimePickerState extends State<TimePicker> {
  bool dateTimeOn = false;
  final int id;
  late Box box;
  DateTime selectedDate = DateTime.now();

  _TimePickerState(this.id);

  @override
  void initState() {
    box = Hive.box('yando_tasks');
    super.initState();
  }

  String getMonth({required int index}) {
    switch (index) {
      case 0:
        return 'января';
      case 1:
        return 'февраля';
      case 2:
        return 'марта';
      case 3:
        return 'апреля';
      case 4:
        return 'мая';
      case 5:
        return 'июня';
      case 6:
        return 'июля';
      case 7:
        return 'августа';
      case 8:
        return 'сентября';
      case 9:
        return 'октября';
      case 10:
        return 'ноября';
      case 11:
        return 'декабря';
      default:
        return '';
    }
  }

  void initWidgets() {
    box = Hive.box('yando_tasks');
    final taskModel = TaskModel.fromJson(box.getAt(id));
    dateTimeOn = taskModel.dateTime != null;
  }

  void saveInfo() {
    final taskModel = TaskModel.fromJson(box.getAt(id));
    if (!dateTimeOn) {
      taskModel.dateTime = null;
    } else {
      taskModel.dateTime = selectedDate;
    }
    box.putAt(id, taskModel.toJson());
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      final box = Hive.box('yando_tasks');
      final taskModel = TaskModel.fromJson(box.getAt(id));
      taskModel.dateTime = picked;
      box.putAt(id, taskModel.toJson());
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    initWidgets();
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Сделать до',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            if (dateTimeOn)
              InkWell(
                onTap: _selectDate,
                borderRadius: BorderRadius.circular(8),
                child: Text(
                  '${selectedDate.day} '
                  '${getMonth(index: selectedDate.month)}'
                  ' ${selectedDate.year}',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ),
              )
            else
              const SizedBox(height: 18),
          ],
        ),
        Switch(
          value: dateTimeOn,
          onChanged: (value) {
            dateTimeOn = value;
            saveInfo();
            setState(() {});
          },
        ),
      ],
    );
  }
}
