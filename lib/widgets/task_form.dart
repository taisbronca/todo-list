import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskForm extends StatefulWidget {
  final Function(String title, String description, DateTime date)? onAddTask;
  final Function(String title, String description, DateTime date)? onEditTask;
  final String? initialTitle;
  final String? initialDescription;
  final DateTime? initialDate;

  TaskForm({
    this.onAddTask,
    this.onEditTask,
    this.initialTitle,
    this.initialDescription,
    this.initialDate,
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
    _descriptionController = TextEditingController(text: widget.initialDescription);
    _selectedDate = widget.initialDate;
    isEditing = widget.initialTitle != null || widget.initialDescription != null || widget.initialDate != null;
  }

  void _submitForm() {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final date = _selectedDate;

    if (title.isEmpty || description.isEmpty || date == null) {
      return;
    }

    if (isEditing && widget.onEditTask != null) {
      widget.onEditTask!(title, description, date);
    } else {
      widget.onAddTask!(title, description, date);
    }
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            locale: Locale('pt', 'BR'))
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
            decoration: InputDecoration(labelText: 'Título'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(labelText: 'Descrição'),
          ),
          SizedBox(height: 20),
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
                child: Text(
                  'Selecionar Data',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitForm,
             child: Text(isEditing ? 'Editar Tarefa' : 'Adicionar Tarefa'),
          ),
        ],
      ),
    );
  }
}
