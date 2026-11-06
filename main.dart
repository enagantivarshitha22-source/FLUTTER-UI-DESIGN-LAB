import 'package:flutter/material.dart';

void main() => runApp(const ReminderWidgetsApp());

class ReminderWidgetsApp extends StatelessWidget {
  const ReminderWidgetsApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Reminder Widgets',
    home: Scaffold(
      appBar: AppBar(title: const Text('Alarm Reminder')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('My Reminders', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          const Card(child: ListTile(leading: Icon(Icons.alarm), title: Text('Study Flutter'), subtitle: Text('Reminder'))),
          const Card(child: ListTile(leading: Icon(Icons.school), title: Text('College Time'), subtitle: Text('Reminder'))),
          const Card(child: ListTile(leading: Icon(Icons.assignment), title: Text('Complete Assignment'), subtitle: Text('Reminder'))),
          const Spacer(),
          SizedBox(width: double.infinity, child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('Add Reminder'),
          )),
        ]),
      ),
    ),
  );
}
