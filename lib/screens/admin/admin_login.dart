// lib/screens/admin/admin_login.dart
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({Key? key}) : super(key: key);

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _adminId = TextEditingController();
  final _adminPass = TextEditingController();
  bool _loading = false;

  // show your protected admin contact here
  final String _adminContact = '+91 93631 51370';

  void _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 700));

    // Requirement: admin id must contain the word "admin" (case-insensitive)
    if (!_adminId.text.toLowerCase().contains('admin')) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Admin ID must contain "admin"')));
      return;
    }

    // For demo we accept any password if admin id passes
    setState(() => _loading = false);
    Navigator.pushReplacementNamed(context, '/admin_dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    // Left gradient branding
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 420,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [Color(0xFFFF5F7A), Color(0xFFFF7A95)]),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Logo (make sure asset exists)
                            Image.asset('assets/images/tracki_logo.jpg',
                                width: 96, height: 96),
                            const SizedBox(height: 12),
                            const Text('Admin Access',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800)),
                            const SizedBox(height: 8),
                            Text(_adminContact,
                                style: const TextStyle(color: Colors.white70)),
                            const SizedBox(height: 10),
                            const Text('Protected',
                                style: TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 18),

                    // right: form
                    Expanded(
                      flex: 6,
                      child: SizedBox(
                        height: 420,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                const Text('Admin Login',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800)),
                                const Spacer(),
                                IconButton(
                                    onPressed: () =>
                                        Navigator.maybePop(context),
                                    icon: const Icon(Icons.close))
                              ]),
                              const SizedBox(height: 18),
                              TextFormField(
                                controller: _adminId,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.person_outline),
                                    hintText:
                                        'Enter admin ID (must contain "admin")'),
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                        ? 'Required'
                                        : null,
                              ),
                              const SizedBox(height: 12),
                              TextFormField(
                                controller: _adminPass,
                                decoration: const InputDecoration(
                                    prefixIcon: Icon(Icons.lock_outline),
                                    hintText: 'Password'),
                                obscureText: true,
                                validator: (v) => (v == null || v.isEmpty)
                                    ? 'Required'
                                    : null,
                              ),
                              const SizedBox(height: 14),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: _loading ? null : _login,
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    backgroundColor: const Color(0xFFFF5F7A),
                                  ),
                                  child: _loading
                                      ? const SizedBox(
                                          height: 18,
                                          width: 18,
                                          child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2))
                                      : const Text('Access System',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700)),
                                ),
                              ),
                              const Spacer(),
                              Center(
                                  child: Text(
                                      'Your admin contact: $_adminContact',
                                      style: const TextStyle(
                                          color: Colors.black54)))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
