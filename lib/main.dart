import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterassignement/database/database_helper.dart';
import 'package:flutterassignement/router/routes.dart';
import 'package:flutterassignement/screens/add_task_screen.dart';
import 'package:flutterassignement/screens/home_screen.dart';
import 'package:flutterassignement/theme/theme_notifier.dart';
import 'package:hive_flutter/adapters.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DatabaseHelper();

  await dbHelper.database;
  const AndroidInitializationSettings androidSettings =
      AndroidInitializationSettings(
          '@mipmap/ic_launcher'); // Change to your app icon
  const InitializationSettings initializationSettings =
      InitializationSettings(android: androidSettings);

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Initialize Hive
  await Hive.initFlutter();

  // Open a Hive box for theme data
  await Hive.openBox('themeBox');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRoute = ref.watch(navigationStateProvider);
    final themeMode = ref.watch(themeNotifierProvider);

    // Widget screen =
    //     RouteConfig.routes[navigationState.currentRoute]?.call(context) ??
    //         const HomeScreen();

    return MaterialApp(
      initialRoute: currentRoute,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeMode,
      // Use the current theme mode
      routes: {
        Routes.homeScreen: (context) => const HomeScreen(),
        Routes.addTaskScreen: (context) => AddTaskScreen(),
      },
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case Routes.homeScreen:
      //       return MaterialPageRoute(builder: (_) => const HomeScreen());
      //     case Routes.addTaskScreen:
      //       return MaterialPageRoute(builder: (_) =>  AddTaskScreen());
      //     default:
      //       return null;
      //   }
      // },
    );
  }
}
