import 'package:flutter/material.dart';

void main() => runApp(const AlarmReminderApp());

class AlarmReminderApp extends StatelessWidget {
  const AlarmReminderApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Alarm Reminder',
    theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
    home: const AlarmHomePage(),
  );
}

class AlarmHomePage extends StatefulWidget {
  const AlarmHomePage({super.key});
  @override
  State<AlarmHomePage> createState() => _AlarmHomePageState();
}

class _AlarmHomePageState extends State<AlarmHomePage> {
  final List<String> reminders = ['Study Flutter', 'College Time', 'Complete Assignment'];
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void addReminder() {
    showDialog(context: context, builder: (dialogContext) => AlertDialog(
      title: const Text('Add Reminder'),
      content: TextField(
        controller: controller,
        autofocus: true,
        decoration: const InputDecoration(hintText: 'Enter reminder name'),
        onSubmitted: (_) => submitReminder(dialogContext),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(dialogContext), child: const Text('Cancel')),
        ElevatedButton(onPressed: () => submitReminder(dialogContext), child: const Text('Add')),
      ],
    ));
  }

  void submitReminder(BuildContext dialogContext) {
    final value = controller.text.trim();
    if (value.isNotEmpty) {
      setState(() => reminders.add(value));
      controller.clear();
      Navigator.pop(dialogContext);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Alarm Reminder')),
    body: Padding(
      padding: const EdgeInsets.all(12),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(padding: EdgeInsets.all(8), child: Text('My Reminders', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
        Expanded(child: reminders.isEmpty
          ? const Center(child: Text('No reminders yet. Tap + to add one.'))
          : ListView.builder(
            itemCount: reminders.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                leading: const Icon(Icons.alarm, color: Colors.deepPurple),
                title: Text(reminders[index]),
                subtitle: const Text('Reminder'),
                trailing: IconButton(
                  tooltip: 'Delete reminder',
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => setState(() => reminders.removeAt(index)),
                ),
              ),
            ),
          )),
      ]),
    ),
    floatingActionButton: FloatingActionButton(onPressed: addReminder, child: const Icon(Icons.add)),
  );
}
