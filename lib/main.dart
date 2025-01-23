import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterassignement/database/database_helper.dart';
import 'package:flutterassignement/router/navigation_state.dart';
import 'package:flutterassignement/router/routes.dart';
import 'package:flutterassignement/screens/add_task_screen.dart';
import 'package:flutterassignement/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();

  final db = await dbHelper.database;

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = ref.watch(navigationStateProvider);

    // Widget screen =
    //     RouteConfig.routes[navigationState.currentRoute]?.call(context) ??
    //         const HomeScreen();

    return MaterialApp(
      initialRoute: currentRoute,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case Routes.homeScreen:
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case Routes.addTaskScreen:
            return MaterialPageRoute(builder: (_) =>  AddTaskScreen());
          default:
            return null;
        }
      },
    );
  }
}
