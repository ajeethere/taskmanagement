

import 'package:flutter/material.dart';

Future<void> showDeleteConfirmationDialog(
    BuildContext context,
    VoidCallback onConfirm,
    ) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              onConfirm(); // Execute the delete action
            },
            child: const Text('Delete'),
          ),
        ],
      );
    },
  );
}

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black), // Default for light mode
    bodyMedium: TextStyle(color: Colors.black),
    bodySmall: TextStyle(color: Colors.black),
  ),
  cardColor: Colors.white, // Ensure card color is also light
);

final darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white), // Default for dark mode
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
  ),
  cardColor: Colors.grey[900], // Ensure card color is dark
);
