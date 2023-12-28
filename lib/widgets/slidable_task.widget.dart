import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:todoapp/cubit/tasks/tasks.bloc.dart';
import 'package:todoapp/models/task.model.dart';
import 'package:todoapp/widgets/create_task.widget.dart';

class SlidableTask extends StatelessWidget {
  const SlidableTask({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final provider = BlocProvider.of<TasksCubit>(context);
    final DateTime dateTime = task.executionDate;

    final String displayDateTime = [
      dateTime.hour.toString().padLeft(2, '0'),
      dateTime.minute.toString().padLeft(2, '0'),
    ].join(':');

    return Slidable(
      closeOnScroll: false,
      key: ValueKey<int>(task.id!),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (BuildContext context) {
              showDialog(
                builder: (ctx) => CreateTaskWidget(
                  task: task,
                  onSubmit: (Task newTask) async {
                    provider.updateTask(newTask);
                    Navigator.of(ctx).pop();
                  },
                ),
                context: context,
              );
            },
            backgroundColor: const Color.fromARGB(255, 11, 135, 151),
            foregroundColor: Colors.white,
            icon: Icons.edit_document,
            label: 'Editar',
          ),
          SlidableAction(
            onPressed: (BuildContext context) {
              final snackBar = SnackBar(
                content: const Text('Tarefa removida da lista.'),
                action: SnackBarAction(
                  label: 'Desfazer',
                  onPressed: () => provider.addTask(task),
                ),
              );

              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              provider.removeTask(id: task.id!);
            },
            backgroundColor: const Color.fromARGB(255, 134, 52, 52),
            foregroundColor: Colors.white,
            icon: Icons.delete_rounded,
            label: 'Excluir',
          ),
        ],
      ),
      child: CheckboxListTile(
        checkboxShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        checkColor: Colors.white,
        fillColor: MaterialStatePropertyAll(
          task.ended == true ? Colors.blue : null,
        ),
        value: task.ended,
        controlAffinity: ListTileControlAffinity.leading,
        onChanged: (value) {
          final updatedTask = Task(
            executionDate: task.executionDate,
            description: task.description,
            id: task.id,
            ended: value,
          );
          provider.updateTask(updatedTask);
        },
        title: Text(
          task.description,
          maxLines: 2,
          style: TextStyle(
            fontSize: 18,
            color: task.ended == true ? Colors.white60 : Colors.white,
            fontWeight: FontWeight.w500,
            decoration: task.ended == true ? TextDecoration.lineThrough : null,
            decorationColor: Colors.white,
            decorationThickness: 1.5,
          ),
        ),
        subtitle: Row(
          children: [
            const Icon(
              Icons.access_time_rounded,
              size: 13,
              color: Colors.white60,
            ),
            const SizedBox(width: 5),
            Text(
              displayDateTime,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white60,
                decoration:
                    task.ended == true ? TextDecoration.lineThrough : null,
                decorationColor: Colors.white,
                decorationThickness: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
