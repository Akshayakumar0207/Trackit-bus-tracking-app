import 'package:flutter/material.dart';

class AddDriverPage extends StatefulWidget {
  const AddDriverPage({Key? key}) : super(key: key);

  @override
  State<AddDriverPage> createState() => _AddDriverPageState();
}

class _AddDriverPageState extends State<AddDriverPage> {
  final _form = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _years = TextEditingController();
  final _bus = TextEditingController();
  String _type = 'Permanent';

  void _save() {
    if (!_form.currentState!.validate()) return;
    // In demo we simply pop. In real app save to backend.
    Navigator.pop(context);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Driver saved (demo).')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Add New Driver'), backgroundColor: Colors.indigo),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
          child: Column(children: [
            TextFormField(
                controller: _name,
                decoration: const InputDecoration(hintText: 'Driver Name'),
                validator: (v) => v == null || v.isEmpty ? 'Enter name' : null),
            const SizedBox(height: 8),
            TextFormField(
                controller: _phone,
                decoration: const InputDecoration(hintText: 'Phone Number'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Enter phone' : null),
            const SizedBox(height: 8),
            TextFormField(
                controller: _years,
                decoration: const InputDecoration(
                    hintText: 'Driving Experience (years)')),
            const SizedBox(height: 8),
            TextFormField(
                controller: _bus,
                decoration: const InputDecoration(
                    hintText: 'Allotted Bus (e.g., B112)')),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _type,
              items: ['Permanent', 'Temporary']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (v) => setState(() => _type = v!),
              decoration: const InputDecoration(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: _save, child: const Text('Save Driver'))
          ]),
        ),
      ),
    );
  }
}
