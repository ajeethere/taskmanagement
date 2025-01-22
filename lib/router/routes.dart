import 'package:flutterassignement/screens/add_task_screen.dart';
import 'package:get/get.dart';

import '../screens/home_screen.dart';

class Routes {
  static String homeScreen = '/home_screen';
  static String addTaskScreen = '/add_task_screen';
}

var transitionAnimation = Transition.rightToLeftWithFade;
final getPages = [
  GetPage(
    name: Routes.homeScreen,
    page: () => const HomeScreen(),
    transition: transitionAnimation,
  ),
  GetPage(
    name: Routes.addTaskScreen,
    page: () => const AddTaskScreen(),
    transition: transitionAnimation,
  ),
];
