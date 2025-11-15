import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  String _selectedBus = 'B112';
  final _buses = ['B112', 'B113', 'B88', 'B171', 'B116'];

  void _save() {
    if (!_form.currentState!.validate()) return;
    Navigator.pop(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Student saved (demo).')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Student')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(children: [
            TextFormField(
                controller: _name,
                decoration: const InputDecoration(hintText: 'Student Name'),
                validator: (v) => v == null || v.isEmpty ? 'Enter name' : null),
            const SizedBox(height: 8),
            TextFormField(
                controller: _email,
                decoration: const InputDecoration(hintText: 'Email'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter email' : null),
            const SizedBox(height: 8),
            TextFormField(
                controller: _phone,
                decoration: const InputDecoration(hintText: 'Phone Number')),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _selectedBus,
              items: _buses
                  .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                  .toList(),
              onChanged: (v) => setState(() => _selectedBus = v!),
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _save, child: const Text('Save Student'))
          ]),
        ),
      ),
    );
  }
}
