import 'package:flutter/material.dart';

void main() => runApp(const ReminderNavigationApp());

class ReminderNavigationApp extends StatelessWidget {
  const ReminderNavigationApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Alarm Reminder')),
      body: Center(child: ElevatedButton(
        child: const Text('Open Reminder Details'),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DetailsPage())),
      )),
    ),
  );
}

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Reminder Details')),
    body: const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      Icon(Icons.alarm, size: 64, color: Colors.deepPurple),
      SizedBox(height: 12),
      Text('Study Flutter', style: TextStyle(fontSize: 24)),
      Text('This is the reminder details screen.'),
    ])),
  );
}
