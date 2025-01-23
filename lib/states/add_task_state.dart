import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterassignement/database/repositories/task_repository.dart';
import 'package:flutterassignement/object_models/task_obj.dart';

// State class for Add Task
class AddTaskState {
  final String? taskName;
  final String? taskDescription;
  final DateTime? dueDate;
  final String? priority;

  AddTaskState({
    this.taskName,
    this.taskDescription,
    this.dueDate,
    this.priority,
  });

  AddTaskState copyWith({
    String? taskName,
    String? taskDescription,
    DateTime? dueDate,
    String? priority,
  }) {
    return AddTaskState(
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
    );
  }

  AddTaskState.reset()
      : taskName = '',
        taskDescription = '',
        dueDate = null,
        priority = 'Low';
}

// Notifier to manage task state
class TaskNotifier extends StateNotifier<AddTaskState> {
  TaskNotifier()
      : super(AddTaskState(taskName: '', taskDescription: '', priority: 'Low'));

  void setTaskName(String taskName) {
    state = state.copyWith(taskName: taskName);
  }

  void setTaskDescription(String taskDescription) {
    state = state.copyWith(taskDescription: taskDescription);
  }

  void setDueDate(DateTime dueDate) {
    state = state.copyWith(dueDate: dueDate);
  }

  void reset() {
    state = AddTaskState.reset(); // Reset state to initial empty values
  }

  void setPriority(String priority) {
    state = state.copyWith(priority: priority);
  }

  void insertTask() {
    var taskObj = TaskObj(
      name: state.taskName!,
      description: state.taskDescription,
      priority: state.priority,
      dueDate: state.dueDate.toString(),
    );
    TaskRepository().insertTask(taskObj);
  }
}

// Riverpod provider
final taskNotifierProvider =
StateNotifierProvider<TaskNotifier, AddTaskState>((ref) {
  return TaskNotifier();
});
