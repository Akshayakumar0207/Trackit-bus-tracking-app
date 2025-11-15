import 'package:flutter/material.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);
  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _ctrl = TextEditingController();
  String _error = '';

  void _login() {
    final v = _ctrl.text.trim();
    if (v.toLowerCase() == 'admin') {
      Navigator.pushReplacementNamed(context, '/admin_dashboard',
          arguments: {'admin': 'admin'});
    } else {
      setState(() => _error = 'Invalid admin key. Use "admin" to proceed.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // simple gradient header like your design
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 140,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xFFFF5F7A), Color(0xFFFF7A95)]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(children: [
                  const Icon(Icons.admin_panel_settings,
                      color: Colors.white, size: 28),
                  const SizedBox(width: 12),
                  const Text('Admin Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                ]),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Admin Access',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w800)),
                    const SizedBox(height: 8),
                    const Text(
                        'Enter your admin credentials to manage the system',
                        style: TextStyle(color: Colors.black54)),
                    const SizedBox(height: 18),
                    TextField(
                      controller: _ctrl,
                      decoration: InputDecoration(
                        hintText: 'Enter admin ID (must contain "admin")',
                        prefixIcon: const Icon(Icons.shield_outlined),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    const SizedBox(height: 12),
                    if (_error.isNotEmpty)
                      Text(_error, style: const TextStyle(color: Colors.red)),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        backgroundColor: const Color(0xFFFF7A95),
                      ),
                      child: const Center(
                          child: Text('Access System',
                              style: TextStyle(fontSize: 16))),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
