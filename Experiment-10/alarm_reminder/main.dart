import 'package:flutter/material.dart';

void main() {
  String appName = 'Alarm Reminder';
  List<String> reminders = ['Study Flutter', 'College Time', 'Complete Assignment'];
  runApp(ReminderBasicsApp(appName: appName, reminders: reminders));
}

class ReminderBasicsApp extends StatelessWidget {
  final String appName;
  final List<String> reminders;
  const ReminderBasicsApp({super.key, required this.appName, required this.reminders});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appName,
      home: Scaffold(
        appBar: AppBar(title: Text(appName)),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Experiment 1: Dart variables and lists',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            for (int i = 0; i < reminders.length; i++)
              Card(child: ListTile(
                leading: const Icon(Icons.alarm),
                title: Text(reminders[i]),
                subtitle: Text('Reminder ${i + 1}'),
              )),
            const SizedBox(height: 8),
            Text('Total reminders: ${reminders.length}'),
          ],
        ),
      ),
    );
  }
}
