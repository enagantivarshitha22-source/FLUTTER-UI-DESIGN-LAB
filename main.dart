import 'package:flutter/material.dart';

void main() => runApp(const ReminderStateApp());

class ReminderStateApp extends StatelessWidget {
  const ReminderStateApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(home: Scaffold(
    appBar: AppBar(title: const Text('Reminder Counter')),
    body: const ReminderCounter(),
  ));
}

class ReminderCounter extends StatefulWidget {
  const ReminderCounter({super.key});
  @override
  State<ReminderCounter> createState() => _ReminderCounterState();
}

class _ReminderCounterState extends State<ReminderCounter> {
  int completed = 0;
  @override
  Widget build(BuildContext context) => Center(child: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const Icon(Icons.task_alt, size: 60, color: Colors.deepPurple),
      const Text('Completed reminders', style: TextStyle(fontSize: 20)),
      Text('$completed', style: const TextStyle(fontSize: 40)),
      Row(mainAxisSize: MainAxisSize.min, children: [
        ElevatedButton(onPressed: completed > 0 ? () => setState(() => completed--) : null, child: const Text('-')),
        const SizedBox(width: 12),
        ElevatedButton(onPressed: () => setState(() => completed++), child: const Text('Mark complete')),
      ]),
    ],
  ));
}
