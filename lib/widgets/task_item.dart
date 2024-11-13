// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task.dart';
import '../constants/colors.dart';

class TaskItem extends StatelessWidget {
  final Task task;
  final Function(Task) onTaskChanged;
  final Function(String?) onDeleteTask;
  final Function(Task) onEditTask;

  const TaskItem({
    Key? key,
    required this.task,
    required this.onTaskChanged,
    required this.onDeleteTask,
    required this.onEditTask,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: ListTile(
        onTap: () {
          onTaskChanged(task);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: Colors.white,
        leading: Icon(
          task.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: tdBlue,
        ),
        title: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title!,
                    style: TextStyle(
                      fontSize: 16,
                      color: tdBlack,
                      fontWeight: FontWeight.bold,
                      decoration:
                          task.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    task.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: Text(
               task.date != null ? DateFormat('dd/MM').format(task.date!) : '',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.right,
              ),
            ),
           PopupMenuButton<String>(
              icon: Icon(Icons.more_vert, color: tdBlack),
              onSelected: (String choice) {
                if (choice == 'Editar') {
                  onEditTask(task);
                } else if (choice == 'Deletar') {
                  onDeleteTask(task.id);
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'Editar',
                  child: Text('Editar'),
                ),
                PopupMenuItem<String>(
                  value: 'Deletar',
                  child: Text('Deletar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
