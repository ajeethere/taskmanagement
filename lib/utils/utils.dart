

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