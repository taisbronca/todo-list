// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';
import '../models/task_list.dart';

class TaskForm extends StatefulWidget {
  final String? initialTitle;
  final String? initialDescription;
  final DateTime? initialDate;
  final String? taskId;
  final void Function(String title, String description, DateTime date)?
      onAddTask;
  final void Function(String title, String description, DateTime date)?
      onEditTask;

  const TaskForm({
    super.key,
    this.initialTitle,
    this.initialDescription,
    this.initialDate,
    this.taskId,
    this.onAddTask,
    this.onEditTask,
  });

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _selectedDate;
  late bool isEditing;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController =
        TextEditingController(text: widget.initialDescription);
    _selectedDate = widget.initialDate;
    isEditing = widget.taskId != null;
  }

  void _submitForm() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final date = _selectedDate;

    if (title.isEmpty || description.isEmpty || date == null) {
      _showErrorDialog(
          'Por favor, preencha todos os campos e selecione uma data.');
      return;
    }

    final taskListProvider = Provider.of<TaskList>(context, listen: false);

    if (isEditing) {
      taskListProvider.editTask(widget.taskId!, title, description, date);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tarefa editada com sucesso!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      final newTask = Task(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        date: date,
      );
      taskListProvider.addTask(newTask);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tarefa adicionada com sucesso!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
    Navigator.of(context).pop();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Erro'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            locale: const Locale('pt', 'BR'))
        .then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(labelText: 'Descrição'),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Text(
                  _selectedDate == null
                      ? 'Nenhuma data selecionada'
                      : 'Data: ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}',
                ),
              ),
              TextButton(
                onPressed: _presentDatePicker,
                child: const Text(
                  'Selecionar Data',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
            child: Text(isEditing ? 'Editar Tarefa' : 'Adicionar Tarefa'),
          ),
        ],
      ),
    );
  }
}
