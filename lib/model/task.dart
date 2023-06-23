import 'package:yando/database/locale_data.dart';
import 'package:yando/model/importance.dart';

class TaskModel {
  int id; // String on Server
  String text;
  String importance;
  DateTime? deadline; // int on Server
  bool done;
  String? color;
  DateTime createdAt; // int on Server
  DateTime changedAt; // int on Server
  String lastUpdatedBy;

  TaskModel({
    required this.id,
    required this.text,
    required this.importance,
    required this.deadline,
    required this.done,
    required this.color,
    required this.createdAt,
    required this.changedAt,
    required this.lastUpdatedBy,
  });

  TaskModel.defaultTask()
      : id = LocaleData.instance.newId,
        text = '',
        importance = Importance.basic.name,
        deadline = null,
        done = false,
        color = null,
        createdAt = DateTime.now(),
        changedAt = DateTime.now(),
        lastUpdatedBy = LocaleData.instance.deviceId;

  TaskModel.defaultWithTextTask(this.text)
      : id = LocaleData.instance.newId,
        importance = Importance.basic.name,
        deadline = null,
        done = false,
        color = null,
        createdAt = DateTime.now(),
        changedAt = DateTime.now(),
        lastUpdatedBy = LocaleData.instance.deviceId;

  TaskModel.fromJson(Map<dynamic, dynamic> json)
      : id = json['id'],
        text = json['text'],
        importance = json['importance'],
        deadline = json['deadline'],
        done = json['done'],
        color = json['color'],
        createdAt = json['created_at'],
        changedAt = json['changed_at'],
        lastUpdatedBy = json['last_updated_by'];

  Map<dynamic, dynamic> toJson() => {
        'id': id,
        'text': text,
        'importance': importance,
        'deadline': deadline,
        'done': done,
        'color': color,
        'created_at': createdAt,
        'changed_at': changedAt,
        'last_updated_by': lastUpdatedBy
      };

  // ChangeIT
  TaskModel.fromJsonServer(Map<dynamic, dynamic> json)
      : id = json['id'],
        text = json['text'],
        importance = json['importance'],
        deadline = json['deadline'],
        done = json['done'],
        color = json['color'],
        createdAt = json['created_at'],
        changedAt = json['changed_at'],
        lastUpdatedBy = json['last_updated_by'];

  // To Json Server
  Map<dynamic, dynamic> toJsonServer() => {
        'id': id,
        'text': text,
        'importance': importance,
        'deadline': deadline,
        'done': done,
        'color': color,
        'created_at': createdAt,
        'changed_at': changedAt,
        'last_updated_by': lastUpdatedBy
      };
}
