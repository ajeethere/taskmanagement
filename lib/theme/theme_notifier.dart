import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(loadInitialTheme());

  static ThemeMode loadInitialTheme() {
    var box = Hive.box('themeBox');
    bool isDarkMode = box.get('isDarkMode', defaultValue: false);
    return isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void toggleTheme() {
    bool isDarkMode = state == ThemeMode.dark;
    state = isDarkMode ? ThemeMode.light : ThemeMode.dark;

    // Save the updated theme preference to Hive
    var box = Hive.box('themeBox');
    box.put('isDarkMode', !isDarkMode);
  }
}

// Create a provider for the theme
final themeNotifierProvider =
StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
