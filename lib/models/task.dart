import 'package:flutter/material.dart';

class Task  with ChangeNotifier{
  final String id;
  String? title;
  String? description;
  DateTime? date;
  bool isDone;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.isDone = false,
  });

//  static List<Task> todoList() {
//    return[
//      Task(id: '01', title: 'teste titulo', description: 'description', date: DateTime.now(), isDone: true),
//      Task(id: '02', title: 'eita eita', description: 'descricaozona mesmo', date: DateTime.now(), isDone: true),
//      Task(id: '03', title: 'teste titulo mais um', description: 'description', date: DateTime.now(), isDone: false),
//      Task(id: '04', title: 'lalalalalalala', description: 'descridescriptiondescriptiondescriptiondescriptionption', date: DateTime.now(), isDone: false),
//    ];
//  }
}