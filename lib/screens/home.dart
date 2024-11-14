// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_list.dart';
import '../widgets/task_form.dart';
import '../constants/colors.dart';
import '../models/task.dart';
import '../widgets/task_item.dart';
import './task_list_page.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Task> _foundTask = [];
  final TextEditingController _taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //_foundTask = Provider.of<TaskList>(context, listen: false).tasks;
    Provider.of<TaskList>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
     final taskList = Provider.of<TaskList>(context);

    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskListPage(
                                title: 'Tarefas Pendentes',
                                filterCompleted: false,
                                onEditTask: _openTaskEditFormModal,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.orangeAccent,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.pending,
                                    color: Colors.white, size: 40),
                                SizedBox(height: 10),
                                Text(
                                  'Pendentes',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TaskListPage(
                                title: "Tarefas Concluídas",
                                filterCompleted: true,
                                onEditTask: _openTaskEditFormModal,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          color: Colors.green,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.check_circle,
                                    color: Colors.white, size: 40),
                                SizedBox(height: 10),
                                Text(
                                  'Concluídas',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 30, bottom: 20, left: 5),
                  child: Text(
                    'Todas as Tarefas',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                  ),
                ),
                Expanded(
            child: taskList.tasks.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView(
                    children: [
                      for (Task todo in taskList.tasks.reversed)
                        TaskItem(
                          task: todo,
                          onTaskChanged: _handleTaskChange,
                          onDeleteTask: _handleTaskDelete,
                          onEditTask: _openTaskEditFormModal,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openTaskFormModal();
        },
        backgroundColor: tdBlue,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }

  void _openTaskFormModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => TaskForm(onAddTask: _handleTaskAdd),
    );
  }

  void _openTaskEditFormModal(Task task) {
  showModalBottomSheet(
    context: context,
    builder: (_) => TaskForm(
      initialTitle: task.title,
      initialDescription: task.description,
      initialDate: task.date,
      taskId: task.id,
      onEditTask: (title, description, date) {
        Provider.of<TaskList>(context, listen: false).editTask(
          task.id,
          title,
          description,
          date,
        );
      },
    ),
  );
}

  void _handleTaskAdd(String title, String description, DateTime date) {
    Provider.of<TaskList>(context, listen: false).addTask(Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      date: date,
    ));
  }

  void _handleTaskDelete(String? id) {
    Provider.of<TaskList>(context, listen: false).deleteTask(id!);
  }

  void _handleTaskEdit(
      String id, String title, String description, DateTime date) {
    Provider.of<TaskList>(context, listen: false)
        .editTask(id, title, description, date);
  }

  void _handleTaskChange(Task task) {
    Provider.of<TaskList>(context, listen: false).toggleTaskStatus(task.id);
  }

  void _handleFilter(String enteredKeyword) {
    final tasksList = Provider.of<TaskList>(context, listen: false).tasks;
    List<Task> results = enteredKeyword.isEmpty
        ? tasksList
        : tasksList
            .where((item) =>
                item.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
            .toList();

    setState(() {
      _foundTask = results;
    });
  }

  Widget searchBox() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
        onChanged: (value) => _handleFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            prefixIcon: Icon(
              Icons.search,
              color: tdGray,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 20,
              minWidth: 25,
            ),
            border: InputBorder.none,
            hintText: 'Pesquisar',
            hintStyle: TextStyle(color: tdGray)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        )
      ]),
    );
  }
}
