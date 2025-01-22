import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterassignement/router/navigation_state.dart';
import 'package:flutterassignement/router/routes.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationNotifier = ref.read(navigationProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: const Text("Tasks List"),),
      body: const Center(
        child: Text("data"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigationNotifier.navigateTo(Routes.addTaskScreen);
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
