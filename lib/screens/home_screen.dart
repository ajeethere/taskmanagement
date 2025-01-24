import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterassignement/router/routes.dart';
import 'package:flutterassignement/states/add_task_state.dart';
import 'package:flutterassignement/states/tasks_state.dart';
import 'package:flutterassignement/utils/utils.dart';

import '../theme/theme_notifier.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskState = ref.watch(tasksNotifier);
    final taskNotifier = ref.read(tasksNotifier.notifier);
    final addTaskNotifier = ref.read(taskNotifierProvider.notifier);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);
    final themeMode = ref.watch(themeNotifierProvider);
    if (!taskState.gotData) {
      taskNotifier.getTasks();
    }

    var textColor = Colors.black;

    if (themeMode == ThemeMode.dark) {
      textColor = Colors.white;
    } else {
      textColor = Colors.black;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        actions: [
          IconButton(
            icon: Icon(themeMode == ThemeMode.dark
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              themeNotifier.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: TextField(
              // controller: taskDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                hintText: "Search Name/Priority/Due Date/Description..."
              ),
              onChanged: (value) {
                taskNotifier.search(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 60),
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
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Description : ${task.description ?? 'No Description'}',
                              style: TextStyle(color: textColor),
                            ),
                            Text(
                              'Priority: ${task.priority ?? 'N/A'}',
                              style: TextStyle(color: textColor, fontSize: 14),
                            ),
                            Text(
                              'Due Date: ${task.dueDate ?? 'N/A'}',
                              style: TextStyle(color: textColor, fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDeleteConfirmationDialog(context, () async {
                                await taskNotifier
                                    .deleteTask(taskState.tasks[index].id);
                                taskNotifier.getTasks();
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () async {
                              addTaskNotifier.reset();
                              await Navigator.pushNamed(context, Routes.addTaskScreen,
                                  arguments: {
                                    "id": taskState.tasks[index].id,
                                    "edit": true,
                                    "reset": true
                                  });
                              taskNotifier.getTasks();
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          addTaskNotifier.reset();
          await Navigator.pushNamed(context, Routes.addTaskScreen,
              arguments: {"reset": true});
          taskNotifier.getTasks();
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
