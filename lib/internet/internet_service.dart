import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yando/database/local_data.dart';
import 'package:yando/logger/logger.dart';
import 'package:yando/model/task.dart';

class IS {
  IS._();

  static IS instance = IS._();

  factory IS() => instance;

  final _dio = Dio();

  Options get _optionsIS => Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${dotenv.get('TOKEN')}',
          'X-Last-Known-Revision': LD.instance.revision,
        },
      );

  Future<List<TaskModel>?> getAll() async {
    List<TaskModel>? listTasks;
    try {
      final response = await _dio.get(
        '${dotenv.get('API_URL')}/list',
        options: _optionsIS,
      );
      LD.instance.revision = response.data['revision'];
      final tasksJson = response.data['list'] as List;
      listTasks = tasksJson.map((e) => TaskModel.fromJsonServer(e)).toList();
    } on DioException catch (e) {
      MyLogger.instance.err(e);
    }
    return listTasks;
  }

  Future<int> getRevision() async {
    try {
      final response = await _dio.get(
        '${dotenv.get('API_URL')}/list',
        options: _optionsIS,
      );
      return LD.instance.revision = response.data['revision'];
    } on DioException catch (e) {
      MyLogger.instance.err(e);
      return -1;
    }
  }

  Future<List<TaskModel>?> updateAll(List<TaskModel> localList) async {
    List<TaskModel>? listTasks = LD.instance.getListTasks();
    try {
      LD.instance.revision = await getRevision();
      final response = await _dio.patch(
        '${dotenv.get('API_URL')}/list',
        options: _optionsIS,
        data: jsonEncode({'list': TaskModel.encodeToJson(localList)}),
      );
      LD.instance.revision = response.data['revision'];
      final tasksJson = response.data['list'] as List;
      listTasks = tasksJson.map((e) => TaskModel.fromJsonServer(e)).toList();
    } on DioException catch (e) {
      MyLogger.instance.err(e);
    }
    return listTasks;
  }

  Future<void> updateTaskById(TaskModel task) async {
    try {
      LD.instance.revision = await getRevision();
      final response = await _dio.put(
        '${dotenv.get('API_URL')}/list/${task.id}',
        options: _optionsIS,
        data: jsonEncode({'element': task.toJsonServer()}),
      );
      LD.instance.revision = response.data['revision'];
    } on DioException catch (e) {
      MyLogger.instance.err(e);
    }
  }

  Future<void> createTask(TaskModel task) async {
    try {
      LD.instance.revision = await getRevision();
      final response = await _dio.post(
        '${dotenv.get('API_URL')}/list',
        options: _optionsIS,
        data: jsonEncode({'element': task.toJsonServer()}),
      );
      LD.instance.revision = response.data['revision'];
    } on DioException catch (e) {
      MyLogger.instance.err(e);
    }
  }

  Future<void> deleteById(int id) async {
    try {
      LD.instance.revision = await getRevision();
      final response = await _dio.delete(
        '${dotenv.get('API_URL')}/list/$id',
        options: _optionsIS,
      );
      LD.instance.revision = response.data['revision'];
    } on DioException catch (e) {
      MyLogger.instance.err(e);
    }
  }
}
