import 'package:flutter/material.dart';
import 'package:flutterassignement/router/routes.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tasks List"),),
      body: const Center(
        child: Text("data"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Get.toNamed(Routes.addTaskScreen);
        },
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ),
    );
  }
}
