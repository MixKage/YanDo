import 'package:yando/database/local_data.dart';
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
      : id = LD.i.newId,
        text = '',
        importance = Importance.basic.name,
        deadline = null,
        done = false,
        color = null,
        createdAt = DateTime.now(),
        changedAt = DateTime.now(),
        lastUpdatedBy = LD.i.idDevice;

  TaskModel.defaultWithTextTask(this.text)
      : id = LD.i.newId,
        importance = Importance.basic.name,
        deadline = null,
        done = false,
        color = null,
        createdAt = DateTime.now(),
        changedAt = DateTime.now(),
        lastUpdatedBy = LD.i.idDevice;

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

  TaskModel.fromJsonServer(Map<dynamic, dynamic> json)
      : id = int.parse(json['id']),
        text = json['text'],
        importance = json['importance'],
        deadline = json['deadline'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(json['deadline']),
        done = json['done'] as bool,
        color = json['color'],
        createdAt = DateTime.fromMillisecondsSinceEpoch(json['created_at']),
        changedAt = DateTime.fromMillisecondsSinceEpoch(json['changed_at']),
        lastUpdatedBy = json['last_updated_by'];

  Map<dynamic, dynamic> toJsonServer() => {
        'id': id.toString(),
        'text': text,
        'importance': importance,
        'deadline': deadline?.millisecondsSinceEpoch,
        'done': done,
        'color': color,
        'created_at': createdAt.millisecondsSinceEpoch,
        'changed_at': changedAt.millisecondsSinceEpoch,
        'last_updated_by': lastUpdatedBy
      };

  static List encodeToJson(List<TaskModel> list) =>
      list.map((item) => item.toJsonServer()).toList();
}
