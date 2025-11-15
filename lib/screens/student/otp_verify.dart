import 'package:flutter/material.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final _otpCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _showReset = false;
  late String expectedOtp;
  late String email;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    expectedOtp = args?['otp']?.toString() ?? '';
    email = args?['email']?.toString() ?? '';
  }

  @override
  void dispose() {
    _otpCtrl.dispose();
    _pwCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    if (_otpCtrl.text.trim() == expectedOtp) {
      setState(() => _showReset = true);
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('OTP verified. Set new password.')));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Invalid OTP')));
    }
  }

  void _resetPassword() {
    final pw = _pwCtrl.text;
    final confirm = _confirmCtrl.text;
    if (pw.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password must be at least 6 chars')));
      return;
    }
    if (pw != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    // TODO: call backend to update password
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Password updated (demo)')));
    Navigator.popUntil(
        context, (route) => route.isFirst); // go back to root or login
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Verify OTP'),
          backgroundColor: const Color(0xFF536DFE)),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Text('OTP sent to $email', style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 18),
            if (!_showReset) ...[
              TextField(
                  controller: _otpCtrl,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.pin),
                      hintText: 'Enter OTP',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)))),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: _verifyOtp,
                  child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      child: Text('Verify OTP'))),
            ] else ...[
              TextField(
                  controller: _pwCtrl,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'New password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)))),
              const SizedBox(height: 12),
              TextField(
                  controller: _confirmCtrl,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline),
                      hintText: 'Confirm password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)))),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: _resetPassword,
                  child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      child: Text('Set New Password'))),
            ]
          ],
        ),
      ),
    );
  }
}
