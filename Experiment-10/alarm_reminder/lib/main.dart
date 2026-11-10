
import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

class Reminder {
  String title;
  DateTime time;
  bool completed;

  Reminder({
    required this.title,
    required this.time,
    this.completed = false,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'time': time.toIso8601String(),
    'completed': completed,
  };

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      title: json['title'],
      time: DateTime.parse(json['time']),
      completed: json['completed'] ?? false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Reminder> reminders = [];
  Timer? reminderTimer;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadReminders();

    reminderTimer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => checkReminders(),
    );
  }

  Future<void> loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('reminders');

    if (saved != null) {
      final List data = jsonDecode(saved);
      reminders = data
          .map((item) => Reminder.fromJson(item))
          .toList();
    } else {
      reminders = [
        Reminder(
          title: 'Study Flutter',
          time: DateTime.now().add(const Duration(days: 1)),
        ),
        Reminder(
          title: 'College Time',
          time: DateTime.now().add(const Duration(days: 2)),
        ),
        Reminder(
          title: 'Complete Assignment',
          time: DateTime.now().add(const Duration(days: 3)),
        ),
      ];
    }

    if (mounted) {
      setState(() => loading = false);
    }

    await saveReminders();
  }

  Future<void> saveReminders() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'reminders',
      jsonEncode(reminders.map((r) => r.toJson()).toList()),
    );
  }

  Future<void> enableNotifications() async {
    try {
      final permission =
          await html.Notification.requestPermission();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            permission == 'granted'
                ? 'Browser notifications enabled!'
                : 'Notification permission was not granted.',
          ),
        ),
      );
    } catch (e) {
      showMessage('Could not enable notifications.');
    }
  }

  void checkReminders() {
    bool changed = false;

    for (final reminder in reminders) {
      if (!reminder.completed &&
          !reminder.time.isAfter(DateTime.now())) {
        reminder.completed = true;
        changed = true;

        if (html.Notification.permission == 'granted') {
          try {
            html.Notification(
              'Alarm Reminder',
              body: reminder.title,
            );
          } catch (e) {
            debugPrint('Notification error: $e');
          }
        }

        if (mounted) {
          showMessage('Reminder: ${reminder.title}');
        }
      }
    }

    if (changed) {
      saveReminders();
      if (mounted) setState(() {});
    }
  }

  Future<void> addReminder() async {
    final reminder = await showDialog<Reminder>(
      context: context,
      builder: (_) => const AddReminderDialog(),
    );

    if (reminder != null) {
      setState(() {
        reminders.add(reminder);
        reminders.sort((a, b) => a.time.compareTo(b.time));
      });

      await saveReminders();
    }
  }

  Future<void> deleteReminder(int index) async {
    setState(() {
      reminders.removeAt(index);
    });
    await saveReminders();
  }

  void showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String formatDate(DateTime date) {
    final d = date.day.toString().padLeft(2, '0');
    final m = date.month.toString().padLeft(2, '0');
    return '$d/$m/${date.year}';
  }

  String formatTime(DateTime date) {
    final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  @override
  void dispose() {
    reminderTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alarm Reminder'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Enable notifications',
            icon: const Icon(Icons.notifications_active),
            onPressed: enableNotifications,
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
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
                  const SizedBox(height: 8),
                  const Text(
                    'Schedule your tasks with date and time.',
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: enableNotifications,
                      icon: const Icon(Icons.notifications),
                      label: const Text('Enable Browser Notifications'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: reminders.isEmpty
                        ? const Center(
                            child: Text('No reminders yet. Add one!'),
                          )
                        : ListView.builder(
                            itemCount: reminders.length,
                            itemBuilder: (context, index) {
                              final reminder = reminders[index];

                              return Card(
                                child: ListTile(
                                  leading: Icon(
                                    reminder.completed
                                        ? Icons.check_circle
                                        : Icons.alarm,
                                    color: reminder.completed
                                        ? Colors.green
                                        : Colors.deepPurple,
                                  ),
                                  title: Text(reminder.title),
                                  subtitle: Text(
                                    '${formatDate(reminder.time)} • '
                                    '${formatTime(reminder.time)}\n'
                                    '${reminder.completed ? "Completed" : "Scheduled"}',
                                  ),
                                  isThreeLine: true,
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.delete_outline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () =>
                                        deleteReminder(index),
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
        onPressed: addReminder,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AddReminderDialog extends StatefulWidget {
  const AddReminderDialog({super.key});

  @override
  State<AddReminderDialog> createState() =>
      _AddReminderDialogState();
}

class _AddReminderDialogState extends State<AddReminderDialog> {
  final controller = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> chooseDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (date != null) {
      setState(() => selectedDate = date);
    }
  }

  Future<void> chooseTime() async {
    final time = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (time != null) {
      setState(() => selectedTime = time);
    }
  }

  void save() {
    final title = controller.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a reminder title')),
      );
      return;
    }

    final dateTime = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime.hour,
      selectedTime.minute,
    );

    if (!dateTime.isAfter(DateTime.now())) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a future date and time'),
        ),
      );
      return;
    }

    Navigator.pop(
      context,
      Reminder(title: title, time: dateTime),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Reminder'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: 'Reminder name',
                hintText: 'Enter reminder title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Select Date'),
              subtitle: Text(
                '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
              ),
              onTap: chooseDate,
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text('Select Time'),
              subtitle: Text(selectedTime.format(context)),
              onTap: chooseTime,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: save,
          child: const Text('Save Reminder'),
        ),
      ],
    );
  }
}
