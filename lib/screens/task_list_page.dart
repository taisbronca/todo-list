import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../models/task.dart';
import '../widgets/task_item.dart';

class TaskListPage extends StatefulWidget {
  final List<Task> tasks;
  final String title;
  final Function(Task) onTaskChanged;
  final Function(String?) onDeleteTask;
  final Function(Task) onEditTask;

  TaskListPage({
    required this.tasks,
    required this.title,
    required this.onTaskChanged,
    required this.onDeleteTask,
    required this.onEditTask,
  });

   @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  late List<Task> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = List.from(widget.tasks);
  }

  @override
  void didUpdateWidget(covariant TaskListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.tasks != widget.tasks) {
      setState(() {
        _tasks = List.from(widget.tasks);
      });
    }
  }

  void _handleTaskChanged(Task task) {
    widget.onTaskChanged(task);
    setState(() {
      final index = _tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        _tasks[index] = task;
      }
    });
  }

  void _handleTaskDelete(String? id) {
    widget.onDeleteTask(id);
    setState(() {
      _tasks.removeWhere((task) => task.id == id);
    });
  }

  void _handleTaskEdit(Task task) {
    widget.onEditTask(task);
    setState(() {
      final taskIndex = _tasks.indexWhere((t) => t.id == task.id);
      if (taskIndex != -1) {
        _tasks[taskIndex] = task;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: tdBGColor,
      elevation: 0,
          title: Text(widget.title),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(top: 20, left: 10, right: 10),
        itemCount: _tasks.length,
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return TaskItem(
            task: task,
            onTaskChanged: _handleTaskChanged,
            onDeleteTask: _handleTaskDelete,
            onEditTask: _handleTaskEdit,
          );
        },
      ),
    );
  }
}
