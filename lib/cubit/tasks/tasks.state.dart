part of "tasks.bloc.dart";

class TasksState extends Equatable {
  final List<Task> tasks;
  final FilterTask filter;

  List<Task> getTasks() {
    if (filter == FilterTask.completed) {
      return tasks.where((Task task) => task.ended == true).toList();
    }
    if (filter == FilterTask.late) {
      return tasks
          .where(
            (Task task) =>
                calculateDifference(task.executionDate) < 0 &&
                task.ended == false,
          )
          .toList();
    }
    return tasks;
  }

  const TasksState({required this.filter, required this.tasks});

  @override
  List<Object> get props => [tasks, filter];
}

enum FilterTask { completed, all, late }
