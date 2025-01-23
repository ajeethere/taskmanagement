import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterassignement/router/routes.dart';
import 'package:flutterassignement/states/tasks_state.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(tasksNotifier);
    final taskNotifier = ref.read(tasksNotifier.notifier);

    taskNotifier.getTasks();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
      ),
      body: ListView.builder(
        itemCount: taskState.tasks.length,
        itemBuilder: (context, index) {
          final task = taskState.tasks[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.name,
                        style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        task.description ?? 'No Description',
                        style: const TextStyle(color: Colors.black54),
                      ),
                      Text(
                        'Priority: ${task.priority ?? 'N/A'}',
                        style: const TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                      Text(
                        'Due Date: ${task.dueDate ?? 'N/A'}',
                        style: const TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {

                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Handle edit action here (e.g., navigate to the edit screen)
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, Routes.addTaskScreen);
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
