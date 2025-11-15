import 'dart:math';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailCtrl = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    super.dispose();
  }

  // simulate sending OTP and navigate to otp screen with generated code
  void _sendOtp() async {
    final email = _emailCtrl.text.trim();
    if (email.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Enter a valid email')));
      return;
    }

    setState(() => _sending = true);
    await Future.delayed(const Duration(seconds: 1)); // simulate network

    // generate 6-digit OTP (for demo only)
    final otp = 100000 + Random().nextInt(900000);
    setState(() => _sending = false);

    // show demo message (in real app do NOT show OTP)
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('OTP sent (demo): $otp')));

    // navigate to OTP verify screen and pass otp and email
    Navigator.pushNamed(context, '/otp_verify',
        arguments: {'email': email, 'otp': otp.toString()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Forgot Password'),
          backgroundColor: const Color(0xFF536DFE)),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(height: 12),
            const Text(
                'Enter your registered email to receive an OTP to reset password',
                style: TextStyle(fontSize: 15)),
            const SizedBox(height: 18),
            TextField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.alternate_email),
                    hintText: 'Enter your college email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 18),
            ElevatedButton(
              onPressed: _sending ? null : _sendOtp,
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  child: Text(_sending ? 'Sending...' : 'Send OTP')),
            ),
          ],
        ),
      ),
    );
  }
}
