import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterassignement/database/repositories/task_repository.dart';
import 'package:flutterassignement/object_models/task_obj.dart';

class TasksState {
  final List<TaskObj> tasks;

  final bool gotData;

  TasksState({required this.tasks, this.gotData=false});

  TasksState copyWith({List<TaskObj>? tasks,required bool gotData}) {
    return TasksState(tasks: tasks ?? this.tasks,gotData: gotData);
  }
}

class TaskNotifier extends StateNotifier<TasksState> {
  TaskNotifier() : super(TasksState(tasks: []));

  Future<void> getTasks() async {
    var tasks = await TaskRepository().getTasks();
    state = state.copyWith(tasks: tasks,gotData: true);
  }

  Future<dynamic> deleteTask(var id)async{
    return await TaskRepository().deleteTask(id);
  }
}

final tasksNotifier = StateNotifierProvider<TaskNotifier, TasksState>((ref) {
  return TaskNotifier();
});
