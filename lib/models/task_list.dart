import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'task.dart';

class TaskList with ChangeNotifier {
  final _baseUrl = 'https://todo-list-b34b2-default-rtdb.firebaseio.com/';
  final List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks.clear();

    final response = await http.get(Uri.parse('$_baseUrl/tasks.json'));
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((taskId, taskData) {
      _tasks.add(Task(
        id: taskId,
        title: taskData['title'],
        description: taskData['description'],
        date: DateTime.parse(taskData['date']),
        isDone: taskData['isDone'] ?? false,
      ));
    });
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    final response = await http.post(Uri.parse('$_baseUrl/tasks.json'),
        body: jsonEncode({
          "title": task.title,
          "description": task.description,
          "date": task.date.toIso8601String(),
        }));

    final id = jsonDecode(response.body)['name'];

    _tasks.add(Task(
        id: id,
        title: task.title,
        description: task.description,
        date: task.date,
        isDone: task.isDone));
    notifyListeners();
  }

  Future<void> deleteTask(String? id) async {
    await http.delete(Uri.parse('$_baseUrl/tasks/$id.json'));
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  Future<void> editTask(
      String id, String title, String description, DateTime date) async {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex != -1) {
      await http.patch(
        Uri.parse('$_baseUrl/tasks/$id.json'),
        body: jsonEncode({
          "title": title,
          "description": description,
          "date": date.toIso8601String(),
        }),
      );
      _tasks[taskIndex] = Task(
          id: id,
          title: title,
          description: description,
          date: date,
          isDone: _tasks[taskIndex].isDone);
      notifyListeners();
    }
  }

  Future<void> toggleTaskStatus(String id) async {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      final newStatus = !_tasks[index].isDone;
      _tasks[index].isDone = newStatus;

      await http.patch(
        Uri.parse('$_baseUrl/tasks/$id.json'),
        body: jsonEncode({
          "isDone": newStatus,
        }),
      );
      notifyListeners();
    }
  }
}
