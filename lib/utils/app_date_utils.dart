import 'package:flutter/material.dart';

class AppDateUtils{
  static Future<DateTime?> pickDate(BuildContext context) async {
    return await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
  }
}