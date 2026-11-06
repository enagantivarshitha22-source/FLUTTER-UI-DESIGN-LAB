import 'package:flutter/material.dart';

void main() => runApp(const ReminderFormApp());

class ReminderFormApp extends StatelessWidget {
  const ReminderFormApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(home: Scaffold(
    appBar: AppBar(title: const Text('Create Reminder')),
    body: const ReminderForm(),
  ));
}

class ReminderForm extends StatefulWidget {
  const ReminderForm({super.key});
  @override
  State<ReminderForm> createState() => _ReminderFormState();
}

class _ReminderFormState extends State<ReminderForm> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Form(
      key: formKey,
      child: Column(children: [
        TextFormField(
          controller: titleController,
          decoration: const InputDecoration(labelText: 'Reminder title', hintText: 'e.g. Study Flutter', border: OutlineInputBorder()),
          validator: (value) => value == null || value.trim().isEmpty ? 'Please enter a reminder title' : null,
        ),
        const SizedBox(height: 16),
        SizedBox(width: double.infinity, child: ElevatedButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Saved: ${titleController.text.trim()}')));
            }
          },
          child: const Text('Save Reminder'),
        )),
      ]),
    ),
  );
}
