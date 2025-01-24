import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterassignement/database/repositories/task_repository.dart';
import 'package:flutterassignement/object_models/task_obj.dart';

// State class for Add Task
class AddTaskState {
  final String? taskName;
  final String? taskDescription;
  final String? dueDate;
  final String? priority;
   bool gotData;

  AddTaskState(
      {this.taskName,
      this.taskDescription,
      this.dueDate,
      this.priority,
      this.gotData = false});

  AddTaskState copyWith(
      {String? taskName,
      String? taskDescription,
      String? dueDate,
      String? priority,
      bool gotData = true}) {
    return AddTaskState(
        taskName: taskName ?? this.taskName,
        taskDescription: taskDescription ?? this.taskDescription,
        dueDate: dueDate ?? this.dueDate,
        priority: priority ?? this.priority,
        gotData: gotData);
  }

  AddTaskState.reset()
      : taskName = '',
        taskDescription = '',
        dueDate = null,
        priority = 'Low',
        gotData = false;
}

class TaskNotifier extends StateNotifier<AddTaskState> {
  TaskNotifier()
      : super(AddTaskState(taskName: '', taskDescription: '', priority: 'Low'));

  void setTaskName(String taskName) {
    state = state.copyWith(taskName: taskName);
  }

  void setTaskDescription(String taskDescription) {
    state = state.copyWith(taskDescription: taskDescription);
  }

  void setDueDate(String dueDate) {
    state = state.copyWith(dueDate: dueDate);
  }

  void reset() {
    state = AddTaskState.reset();
  }

  void setPriority(String priority) {
    state = state.copyWith(priority: priority);
  }

  Future<void> getTask(var id) async {
    var task = await TaskRepository().getTaskById(id);
    state = state.copyWith(
        taskName: task?.name,
        taskDescription: task?.description,
        priority: task?.priority,
        dueDate: task?.dueDate,
        gotData: true);
  }

  Future<void> insertTask() async {
    var taskObj = TaskObj(
      name: state.taskName!,
      description: state.taskDescription,
      priority: state.priority,
      dueDate: state.dueDate,
    );
    await TaskRepository().insertTask(taskObj);
  }

  Future<void> editTask(var id) async {
    var taskObj = TaskObj(
      id: id,
      name: state.taskName!,
      description: state.taskDescription,
      priority: state.priority,
      dueDate: state.dueDate,
    );
    await TaskRepository().updateTask(taskObj);
  }
}

// Riverpod provider
final taskNotifierProvider =
    StateNotifierProvider<TaskNotifier, AddTaskState>((ref) {
  return TaskNotifier();
});
