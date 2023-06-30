import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yando/database/locale_data.dart';
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
          'X-Last-Known-Revision': LocaleData.instance.revision,
        },
      );

  Future<List<TaskModel>?> getAll() async {
    List<TaskModel>? listTasks;
    try {
      final response = await _dio.get(
        '${dotenv.get('API_URL')}/list',
        options: _optionsIS,
      );
      LocaleData.instance.revision = response.data['revision'];
      final tasksJson = response.data['list'] as List;
      listTasks = tasksJson.map((e) => TaskModel.fromJsonServer(e)).toList();
    } on DioException catch (e) {
      MyLogger.instance.err(e);
    }
    return listTasks;
  }

  Future<List<TaskModel>?> updateAll(List<TaskModel> localList) async {
    List<TaskModel>? listTasks;
    try {
      final response = await _dio.patch(
        '${dotenv.get('API_URL')}/list',
        options: _optionsIS,
        data: 'list: ${TaskModel.encondeToJson(localList)}',
      );
      LocaleData.instance.revision = response.data['revision'];
      final tasksJson = response.data['list'] as List;
      listTasks = tasksJson.map((e) => TaskModel.fromJsonServer(e)).toList();
    } on DioException catch (e) {
      MyLogger.instance.err(e);
    }
    return listTasks;
  }

  Future<void> updateTaskById(TaskModel task) async {
    try {
      final response = await _dio.put(
        '${dotenv.get('API_URL')}/list/${task.id}',
        options: _optionsIS,
        data: jsonEncode({'element': task.toJsonServer()}),
      );
      LocaleData.instance.revision = response.data['revision'];
    } on DioException catch (e) {
      MyLogger.instance.err(e);
    }
  }

  Future<void> createTask(TaskModel task) async {
    try {
      final response = await _dio.post(
        '${dotenv.get('API_URL')}/list',
        options: _optionsIS,
        data: jsonEncode({'element': task.toJsonServer()}),
      );
      LocaleData.instance.revision = response.data['revision'];
    } on DioException catch (e) {
      MyLogger.instance.err(e);
    }
  }

  Future<void> deleteById(int id) async {
    try {
      final response = await _dio.delete(
        '${dotenv.get('API_URL')}/list/$id',
        options: _optionsIS,
      );
      LocaleData.instance.revision = response.data['revision'];
    } on DioException catch (e) {
      MyLogger.instance.err(e);
    }
  }
}
