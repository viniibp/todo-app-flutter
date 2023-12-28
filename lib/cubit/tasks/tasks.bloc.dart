import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todoapp/db/tasks.repository.dart';
import 'package:todoapp/models/task.model.dart';
import 'package:todoapp/utils/calculate_date.dart';

part "tasks.state.dart";

class TasksCubit extends Cubit<TasksState> {
  final _tasksDB = TasksDB();

  TasksCubit() : super(const TasksState(tasks: [], filter: FilterTask.all));

  Future<void> getTasks() async {
    try {
      final data = await _tasksDB.fetchAll();
      emit(TasksState(tasks: data, filter: state.filter));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> addTask(Task task) async {
    _tasksDB.create(task);
    getTasks();
  }

  Future<void> removeTask({required int id}) async {
    _tasksDB.delete(id: id);
    getTasks();
  }

  Future<void> updateTask(Task task) async {
    _tasksDB.update(task);
    getTasks();
  }

  void changeFilter(FilterTask filter) {
    emit(TasksState(tasks: state.tasks, filter: filter));
  }
}
