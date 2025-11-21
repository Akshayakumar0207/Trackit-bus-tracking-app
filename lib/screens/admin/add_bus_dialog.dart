// lib/screens/admin/add_bus_dialog.dart
import 'package:flutter/material.dart';

class AddBusDialog extends StatefulWidget {
  const AddBusDialog({Key? key}) : super(key: key);

  @override
  State<AddBusDialog> createState() => _AddBusDialogState();
}

class _AddBusDialogState extends State<AddBusDialog> {
  final _formKey = GlobalKey<FormState>();
  final _busNo = TextEditingController();
  String? _route;
  final _students = TextEditingController();

  @override
  void dispose() {
    _busNo.dispose();
    _students.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    Navigator.of(context).pop({
      'busNumber': _busNo.text.trim(),
      'route': _route ?? 'Unknown',
      'students': int.tryParse(_students.text.trim()) ?? 0,
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Bus'),
      content: Form(
        key: _formKey,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          TextFormField(
            controller: _busNo,
            decoration:
                const InputDecoration(labelText: 'Bus Number (eg B112)'),
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Enter bus number' : null,
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _route,
            decoration: const InputDecoration(labelText: 'Route'),
            items: const [
              DropdownMenuItem(value: 'Salem', child: Text('Salem')),
              DropdownMenuItem(value: 'Erode', child: Text('Erode')),
              DropdownMenuItem(value: 'Rasipuram', child: Text('Rasipuram')),
              DropdownMenuItem(value: 'Namakkal', child: Text('Namakkal')),
            ],
            onChanged: (v) => setState(() => _route = v),
            validator: (v) => v == null || v.isEmpty ? 'Select route' : null,
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _students,
            decoration: const InputDecoration(labelText: 'No. of students'),
            keyboardType: TextInputType.number,
            validator: (v) =>
                (v == null || v.trim().isEmpty) ? 'Enter number' : null,
          ),
        ]),
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel')),
        ElevatedButton(onPressed: _save, child: const Text('Add Bus')),
      ],
    );
  }
}
