import 'package:flutter_riverpod/flutter_riverpod.dart';

class Routes {
  static const homeScreen = '/home_screen';
  static const addTaskScreen = '/add_task_screen';
}
final navigationStateProvider = StateProvider<String>((ref) => Routes.homeScreen);
