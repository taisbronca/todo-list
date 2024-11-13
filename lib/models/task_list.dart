import 'package:flutter/material.dart';

import 'task.dart';

class TaskList with ChangeNotifier {
  List<Task> _tasks = [
    Task(
        id: '01',
        title: 'teste titulo',
        description: 'description',
        date: DateTime.now(),
        isDone: true),
    Task(
        id: '02',
        title: 'eita eita',
        description: 'descricaozona mesmo',
        date: DateTime.now(),
        isDone: true),
    Task(
        id: '03',
        title: 'teste titulo mais um',
        description: 'description',
        date: DateTime.now(),
        isDone: false),
    Task(
        id: '04',
        title: 'lalalalalalala',
        description: 'descridescriptiondescriptiondescriptiondescriptionption',
        date: DateTime.now(),
        isDone: false),
  ];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners();
  }

  void deleteTask(String? id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  void editTask(String id, String title, String description, DateTime date) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index] = Task(
          id: id,
          title: title,
          description: description,
          date: date,
          isDone: _tasks[index].isDone);
      notifyListeners();
    }
  }

  void toggleTaskStatus(String id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index].isDone = !_tasks[index].isDone;
      notifyListeners();
    }
  }
}
