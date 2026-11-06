import 'package:flutter/material.dart';

void main() => runApp(const RowColumnApp());

class RowColumnApp extends StatelessWidget {
  const RowColumnApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Reminder Layout')),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Today', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 18),
          reminderRow(Icons.book, 'Study Flutter', '9:00 AM'),
          reminderRow(Icons.school, 'College Time', '10:00 AM'),
          reminderRow(Icons.assignment, 'Complete Assignment', '5:00 PM'),
        ]),
      ),
    ),
  );
}

Widget reminderRow(IconData icon, String title, String time) => Card(
  child: Padding(
    padding: const EdgeInsets.all(12),
    child: Row(children: [
      Icon(icon, color: Colors.deepPurple, size: 30),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(time),
      ])),
      const Icon(Icons.chevron_right),
    ]),
  ),
);
