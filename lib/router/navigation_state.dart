import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationState {
  final String currentRoute;
  final Object? arguments;

  NavigationState({this.currentRoute = '/', this.arguments});
}

class NavigationNotifier extends StateNotifier<NavigationState> {
  NavigationNotifier() : super(NavigationState());

  void navigateTo(String route, {Object? arguments}) {
    state = NavigationState(currentRoute: route, arguments: arguments);
  }

  void goBack() {
    state = NavigationState(currentRoute: '/');
  }
}

// Create a provider for navigation state
final navigationProvider = StateNotifierProvider<NavigationNotifier, NavigationState>((ref) {
  return NavigationNotifier();
});
