import 'package:flutter/material.dart';

void main() => runApp(const ResponsiveReminderApp());

class ResponsiveReminderApp extends StatelessWidget {
  const ResponsiveReminderApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Responsive Alarm Reminder')),
      body: LayoutBuilder(builder: (context, constraints) {
        final wide = constraints.maxWidth >= 600;
        final items = [
          reminderCard(Icons.book, 'Study Flutter', '9:00 AM'),
          reminderCard(Icons.school, 'College Time', '10:00 AM'),
          reminderCard(Icons.assignment, 'Complete Assignment', '5:00 PM'),
        ];
        return Padding(
          padding: const EdgeInsets.all(16),
          child: wide
            ? GridView.count(crossAxisCount: 3, crossAxisSpacing: 12, children: items)
            : ListView(children: items),
        );
      }),
    ),
  );
}

Widget reminderCard(IconData icon, String title, String time) => Card(
  child: Padding(padding: const EdgeInsets.all(14), child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [Icon(icon, size: 32, color: Colors.deepPurple), const SizedBox(height: 8), Text(title, textAlign: TextAlign.center), Text(time)],
  )),
);
