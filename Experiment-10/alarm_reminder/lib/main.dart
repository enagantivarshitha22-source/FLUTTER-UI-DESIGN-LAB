
import 'package:flutter/material.dart';

void main() {
  runApp(const AlarmReminderApp());
}

class AlarmReminderApp extends StatelessWidget {
  const AlarmReminderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alarm Reminder',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> reminders = [
    'Study Flutter',
    'College Time',
    'Complete Assignment',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm Reminder'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Reminders',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const Icon(
                        Icons.alarm,
                        color: Colors.deepPurple,
                      ),
                      title: Text(reminders[index]),
                      subtitle: const Text('Reminder'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete_outline),
                        onPressed: () {
                          setState(() {
                            reminders.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final controller = TextEditingController();

          final result = await showDialog<String>(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Add Reminder'),
              content: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Enter reminder name',
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, controller.text.trim());
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
          );

          if (result != null && result.isNotEmpty) {
            setState(() {
              reminders.add(result);
            });
          }

          controller.dispose();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
