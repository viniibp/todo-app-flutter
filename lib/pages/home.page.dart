import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todoapp/cubit/tasks/tasks.bloc.dart';
import 'package:todoapp/models/task.model.dart';
import 'package:todoapp/utils/calculate_date.dart';
import 'package:todoapp/widgets/masthead.widget.dart';
import 'package:todoapp/widgets/slidable_task.widget.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Map<DateTime, List<Task>> getTasks(List<Task> tasks) {
    Map<DateTime, List<Task>> tasksByDate = {};

    for (var task in tasks) {
      final DateTime date = DateTime(
        task.executionDate.year,
        task.executionDate.month,
        task.executionDate.day,
      );

      if (tasksByDate.keys.contains(date)) {
        tasksByDate[date]!.add(task);
      } else {
        tasksByDate.addAll({
          date: [task]
        });
      }
    }
    return tasksByDate;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        Map<DateTime, List<Task>> tasksByDate = getTasks(state.getTasks());
        if (tasksByDate.isEmpty) return emptyList();
        return Column(
          children: [
            const Masthead(),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                color: const Color(0xFF111822),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasksByDate.entries.length,
                  itemBuilder: (context, index) {
                    final String title;
                    final date = tasksByDate.entries.toList()[index].key;
                    final int difference = calculateDifference(date);

                    if (difference == 0) {
                      title = 'Hoje';
                    } else if (difference == 1) {
                      title = 'Amanhã';
                    } else if (difference == -1) {
                      title = 'Ontem';
                    } else {
                      title = DateFormat('dd/MM/y').format(date).toString();
                    }

                    final tasks = tasksByDate.entries.toList()[index].value;

                    return Container(
                      decoration: title == 'Hoje'
                          ? BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                              boxShadow: const [
                                BoxShadow(
                                    color: Color.fromARGB(255, 23, 33, 46)),
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                            )
                          : null,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: Text(
                                title,
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          ...tasks
                              .map((Task task) => SlidableTask(task: task))
                              .toList()
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget emptyList() {
    return const Column(
      children: [
        Masthead(),
        SizedBox(height: 50),
        Center(
          child: Text(
            'Sem tarefas!',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
        ),
      ],
    );
  }
}
