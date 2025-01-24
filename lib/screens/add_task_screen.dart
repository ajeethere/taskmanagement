import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterassignement/utils/app_date_utils.dart';
import '../states/add_task_state.dart';

class AddTaskScreen extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
  TextEditingController();

  AddTaskScreen({super.key});

  Future<void> _pickDate(BuildContext context, WidgetRef ref) async {
    DateTime? selectedDate = await AppDateUtils.pickDate(context);
    if (selectedDate != null) {
      ref
          .read(taskNotifierProvider.notifier)
          .setDueDate(selectedDate.toString().split(" ")[0]);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(taskNotifierProvider);
    final taskNotifier = ref.read(taskNotifierProvider.notifier);

    taskDescriptionController.text = taskState.taskDescription!;
    taskNameController.text = taskState.taskName!;
    final args = ModalRoute.of(context)?.settings.arguments as Map?;
    final id = args?['id'];
    final edit = args?['edit'] ?? false;

    if (!taskState.gotData) {
      if (id != null) {
        taskNotifier.getTask(id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign GlobalKey to Form for validation
          child: ListView(
            children: [
              // Task Name
              TextFormField(
                controller: taskNameController,
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  taskNotifier.setTaskName(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a task name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Task Description
              TextFormField(
                controller: taskDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onChanged: (value) {
                  taskNotifier.setTaskDescription(value);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),

              // Due Date
              Row(
                children: [
                  Expanded(
                    child: Text(
                      taskState.dueDate == null
                          ? 'No Due Date Selected'
                          : 'Due Date: ${taskState.dueDate!.toString()}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _pickDate(context, ref);
                    },
                    child: const Text('Select Date'),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Priority (Radio Buttons)
              const Text(
                'Priority',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'Low',
                      groupValue: taskState.priority,
                      title: const Text('Low'),
                      onChanged: (value) {
                        taskNotifier.setPriority(value!);
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'Medium',
                      groupValue: taskState.priority,
                      title: const Text('Medium'),
                      onChanged: (value) {
                        taskNotifier.setPriority(value!);
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      value: 'High',
                      groupValue: taskState.priority,
                      title: const Text('High'),
                      onChanged: (value) {
                        taskNotifier.setPriority(value!);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  taskNotifier.setTaskName(taskNameController.text);
                  taskNotifier
                      .setTaskDescription(taskDescriptionController.text);

                  if (_formKey.currentState!.validate()) {
                    if (taskState.dueDate == null) {
                      return;
                    }
                    if (edit) {
                      ref.read(taskNotifierProvider.notifier).editTask(id);
                    } else {
                      ref.read(taskNotifierProvider.notifier).insertTask();
                    }
                    ref.read(taskNotifierProvider.notifier).reset();
                    Navigator.pop(context);
                  } else {}
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Add Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
