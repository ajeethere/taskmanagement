import 'package:flutter/material.dart';
import 'package:flutterassignement/screens/add_task_screen.dart';

import '../screens/home_screen.dart';

class Routes {
  static String homeScreen = '/home_screen';
  static String addTaskScreen = '/add_task_screen';
}


class RouteConfig {
  static final Map<String, WidgetBuilder> routes = {
    Routes.homeScreen: (_) => const HomeScreen(),
    Routes.addTaskScreen: (_) => const AddTaskScreen(),

  };
}
