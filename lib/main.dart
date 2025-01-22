import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterassignement/router/navigation_state.dart';
import 'package:flutterassignement/router/routes.dart';
import 'package:flutterassignement/screens/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationProvider);

    // Fetch the screen from the RouteConfig map using the current route
    Widget screen =
        RouteConfig.routes[navigationState.currentRoute]?.call(context) ??
            const HomeScreen();

    return MaterialApp(
      home: screen,
      onGenerateRoute: (settings) {
        final builder = RouteConfig.routes[settings.name];
        if (builder != null) {
          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        } else {
          return MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          );
        }
      },
    );
  }
}
