import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterassignement/database/repositories/task_repository.dart';
import 'package:flutterassignement/object_models/task_obj.dart';

class TasksState {
  final List<TaskObj> tasks;
  final List<TaskObj> allTasks;

  final bool gotData;

  TasksState(
      {required this.tasks, required this.allTasks, this.gotData = false});

  TasksState copyWith(
      {List<TaskObj>? tasks, List<TaskObj>? allTasks, required bool gotData}) {
    return TasksState(
        tasks: tasks ?? this.tasks,
        allTasks: allTasks ?? this.allTasks,
        gotData: gotData);
  }
}

class TaskNotifier extends StateNotifier<TasksState> {
  TaskNotifier() : super(TasksState(tasks: [], allTasks: []));

  Future<void> getTasks() async {
    var tasks = await TaskRepository().getTasks();
    state = state.copyWith(tasks: tasks, allTasks: tasks, gotData: true);
  }

  void search(String text) {
    state = state.copyWith(tasks: [], allTasks: state.allTasks, gotData: true);
    if (text.trim() == '') {
      state = state.copyWith(
          tasks: state.allTasks, allTasks: state.allTasks, gotData: true);
    } else {
      for (var i = 0; i <= state.allTasks.length; i++) {
        if (state.allTasks[i].name.toLowerCase().contains(text.toLowerCase()) ||
            state.allTasks[i].description!.toLowerCase().contains(text.toLowerCase()) ||
            state.allTasks[i].dueDate!.toLowerCase().contains(text.toLowerCase()) ||
            state.allTasks[i].priority!.toLowerCase().contains(text.toLowerCase())) {
          state.tasks.add(state.allTasks[i]);
        }
      }
    }
  }

  Future<dynamic> deleteTask(var id) async {
    return await TaskRepository().deleteTask(id);
  }
}

final tasksNotifier = StateNotifierProvider<TaskNotifier, TasksState>((ref) {
  return TaskNotifier();
});
