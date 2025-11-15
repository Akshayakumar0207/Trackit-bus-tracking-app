// lib/screens/alter_bus.dart
import 'package:flutter/material.dart';

class AlterBusScreen extends StatefulWidget {
  const AlterBusScreen({super.key});

  @override
  State<AlterBusScreen> createState() => _AlterBusScreenState();
}

class _AlterBusScreenState extends State<AlterBusScreen> {
  final _formKey = GlobalKey<FormState>();
  String? currentBus = 'B112';
  String? newBus;
  String? newTime;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) currentBus = args['busNumber'] ?? currentBus;
  }

  void _sendAlteration() {
    final f = _formKey.currentState!;
    if (!f.validate()) return;
    f.save();
    // TODO: push to backend to notify students / update bus mapping
    Navigator.pop(context, {'newBus': newBus, 'newTime': newTime});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alter Bus'),
        backgroundColor: const Color(0xFF536DFE),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Current Bus Number',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(currentBus ?? ''),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'New Bus Number (e.g., B161)',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Enter new bus number'
                    : null,
                onSaved: (v) => newBus = v?.trim(),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'New Bus Time (e.g., 8:45 AM)',
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Enter time' : null,
                onSaved: (v) => newTime = v?.trim(),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _sendAlteration,
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Text('Send Alteration'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
