import 'package:agendaku_app/constants/variables.dart';
import 'package:agendaku_app/data/models/add_task_request_model.dart';
import 'package:agendaku_app/data/models/add_task_response_model.dart';
import 'package:agendaku_app/data/models/task_response_model.dart';
import 'package:http/http.dart' as http;

class TaskRemoteDatasource {
  Future<TasksResponseModel> getTask() async {
    final response = await http.get(
      Uri.parse('${Variables.baseUrl}/api/tasks'),
    );
    if (response.statusCode == 200) {
      return TasksResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<AddTaskResponseModel> addTask(AddTaskRequestModel data) async {
    final response = await http.post(
      Uri.parse('${Variables.baseUrl}/api/tasks'),
      body: data.toJson(),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return AddTaskResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<AddTaskResponseModel> deleteTask(int id) async {
    final response = await http.delete(
      Uri.parse('${Variables.baseUrl}/api/tasks/$id'),
    );
    if (response.statusCode == 200) {
      return AddTaskResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<AddTaskResponseModel> updateTask(
      int id, AddTaskRequestModel data) async {
    final response = await http.put(
      Uri.parse('${Variables.baseUrl}/api/tasks/$id'),
      body: data.toJson(),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      return AddTaskResponseModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load tasks');
    }
  }
}
