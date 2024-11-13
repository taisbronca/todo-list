import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../models/task.dart';
import '../models/task_list.dart';
import '../widgets/task_item.dart';

class TaskListPage extends StatelessWidget {
  final String title;
  final bool filterCompleted;
  final Function(Task) onEditTask;

  TaskListPage({
    required this.title,
    required this.filterCompleted,
    required this.onEditTask,
  });

  @override
  Widget build(BuildContext context) {
    final taskListProvider = Provider.of<TaskList>(context);
    final tasks = taskListProvider.tasks
        .where((task) => task.isDone == filterCompleted)
        .toList();

    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,
        title: Text(title),
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text(
                'Nenhuma Tarefa encontrada',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskItem(
                  task: task,
                  onTaskChanged: (_) {
                    taskListProvider.toggleTaskStatus(task.id);
                  },
                  onDeleteTask: (_) {
                    taskListProvider.deleteTask(task.id);
                  },
                  onEditTask: (_) {
                    onEditTask(task);
                  },
                );
              },
            ),
    );
  }
}
