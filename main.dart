import 'package:flutter/material.dart';

void main() => runApp(const InputWidgetsApp());

class InputWidgetsApp extends StatelessWidget {
  const InputWidgetsApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(title: const Text('Reminder Input Widgets')),
      body: const InputDemo(),
    ),
  );
}

class InputDemo extends StatefulWidget {
  const InputDemo({super.key});
  @override
  State<InputDemo> createState() => _InputDemoState();
}

class _InputDemoState extends State<InputDemo> {
  bool enabled = true;
  String priority = 'Normal';
  bool repeatDaily = false;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Reminder settings', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      SwitchListTile(title: const Text('Reminder enabled'), value: enabled, onChanged: (v) => setState(() => enabled = v)),
      DropdownButtonFormField<String>(
        value: priority,
        decoration: const InputDecoration(labelText: 'Priority', border: OutlineInputBorder()),
        items: ['Low', 'Normal', 'High'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (v) => setState(() => priority = v ?? 'Normal'),
      ),
      CheckboxListTile(title: const Text('Repeat every day'), value: repeatDaily, onChanged: (v) => setState(() => repeatDaily = v ?? false)),
      Text('Priority selected: $priority'),
      Text('Daily repeat: ${repeatDaily ? "Yes" : "No"}'),
    ]),
  );
}
