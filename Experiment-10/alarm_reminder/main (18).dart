import 'package:flutter/material.dart';

void main() => runApp(const ReminderListApp());

class ReminderListApp extends StatelessWidget {
  const ReminderListApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(appBar: AppBar(title: const Text('My Reminders')), body: const ReminderList()),
  );
}

class ReminderList extends StatefulWidget {
  const ReminderList({super.key});
  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  final reminders = ['Study Flutter', 'College Time', 'Complete Assignment'];
  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: reminders.length,
    itemBuilder: (context, index) => Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: const Icon(Icons.alarm, color: Colors.deepPurple),
        title: Text(reminders[index]),
        subtitle: const Text('Reminder'),
        trailing: IconButton(icon: const Icon(Icons.delete_outline), onPressed: () => setState(() => reminders.removeAt(index))),
      ),
    ),
  );
}
