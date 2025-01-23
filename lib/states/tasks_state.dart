import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterassignement/database/repositories/task_repository.dart';
import 'package:flutterassignement/object_models/task_obj.dart';

class TasksState {
  final List<TaskObj> tasks;

  TasksState({required this.tasks});

  TasksState copyWith({List<TaskObj>? tasks}) {
    return TasksState(tasks: tasks ?? this.tasks);
  }
}

class TaskNotifier extends StateNotifier<TasksState> {
  TaskNotifier() : super(TasksState(tasks: [])); // Initial empty list of tasks

  Future<void> getTasks() async {
    var tasks = await TaskRepository().getTasks();
    state = state.copyWith(tasks: tasks);
  }
}

final tasksNotifier = StateNotifierProvider<TaskNotifier, TasksState>((ref) {
  return TaskNotifier();
});
