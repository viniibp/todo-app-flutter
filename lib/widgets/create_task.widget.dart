import 'package:flutter/material.dart';
import 'package:todoapp/models/task.model.dart';

class CreateTaskWidget extends StatefulWidget {
  final Task? task;
  final ValueChanged<Task> onSubmit;

  const CreateTaskWidget({Key? key, this.task, required this.onSubmit})
      : super(key: key);

  @override
  State<CreateTaskWidget> createState() => _CreateTaskWidgetState();
}

class _CreateTaskWidgetState extends State<CreateTaskWidget> {
  final controllerDescription = TextEditingController();
  final formKeyDescription = GlobalKey<FormState>();

  DateTime? _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      controllerDescription.text = widget.task?.description ?? '';
      _selectedDate = widget.task?.executionDate ?? DateTime.now();
      _selectedTime = TimeOfDay(
        hour: widget.task!.executionDate.hour,
        minute: widget.task!.executionDate.minute,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;
    return AlertDialog(
      title: Center(
        child: Text(
          isEditing ? 'Edição de Tarefa 📝' : 'Nova Tarefa 🗒️',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color(0xFF111822),
      content: SizedBox(
        height: 200,
        width: 350,
        child: Column(
          children: [
            Form(
              key: formKeyDescription,
              child: TextFormField(
                autofocus: true,
                controller: controllerDescription,
                decoration: const InputDecoration(
                  fillColor: Colors.red,
                  hintText: 'Descrição...',
                ),
                validator: (value) => value != null && value.isEmpty
                    ? 'Precisa de uma descrição!'
                    : null,
              ),
            ),
            const SizedBox(height: 20),
            OutlinedButton(
              onPressed: _selectDate,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_selectedDate?.day}/${_selectedDate?.month}/${_selectedDate?.year}',
                  ),
                  const Icon(Icons.calendar_month)
                ],
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton(
              onPressed: _selectTime,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedTime!.format(context),
                  ),
                  const Icon(Icons.access_time_filled_sharp)
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: _onSubmit,
          child: const Text('Confirmar'),
        ),
      ],
    );
  }

  void _onSubmit() {
    if (formKeyDescription.currentState!.validate()) {
      var date = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      Task task = Task(
        id: widget.task?.id,
        description: controllerDescription.text,
        executionDate: date,
        ended: widget.task?.ended,
      );

      widget.onSubmit(task);
    }
  }

  void _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2200),
      locale: const Locale('pt', 'BR'),
    );

    if (date != null) {
      setState(() {
        _selectedDate = date;
      });
    }
  }

  void _selectTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (time != null) {
      setState(() {
        _selectedTime = time;
      });
    }
  }
}
