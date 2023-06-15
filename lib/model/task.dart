class TaskModel {
  String type;
  bool isChecked;
  String text;
  DateTime? dateTime;

  TaskModel({
    required this.type,
    required this.isChecked,
    required this.text,
    required this.dateTime,
  });

  TaskModel.defaultTask()
      : type = 'Нет',
        isChecked = false,
        text = '',
        dateTime = null;

  TaskModel.defaultWithTextTask(this.text)
      : type = 'Нет',
        isChecked = false,
        dateTime = null;

  TaskModel.fromJson(Map<dynamic, dynamic> json)
      : type = json['type'],
        isChecked = json['isChecked'],
        text = json['text'],
        dateTime = json['dateTime'];

  Map<dynamic, dynamic> toJson() => {
        'type': type,
        'isChecked': isChecked,
        'text': text,
        'dateTime': dateTime,
      };
}
