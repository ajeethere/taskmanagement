import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

void scheduleNotification(DateTime scheduledDate) async {
  tz.initializeTimeZones();

  await flutterLocalNotificationsPlugin.zonedSchedule(
    0,
    'Task Reminder',
    'This is your task reminder notification!',
    tz.TZDateTime.from(scheduledDate, tz.local), // Scheduled time
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'task_channel', // Channel ID
        'Task Notifications', // Channel name
        channelDescription: 'Notifications for tasks',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    androidScheduleMode: AndroidScheduleMode.alarmClock,
  );
}
