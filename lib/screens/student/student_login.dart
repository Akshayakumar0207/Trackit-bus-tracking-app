// lib/screens/student_login.dart
import 'package:flutter/material.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? name, email, password;
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // gradient background like design
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF536DFE), Color(0xFF8E24AA)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            child: Column(
              children: [
                // top bar
                Row(children: [
                  GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.arrow_back_ios,
                              color: Colors.white, size: 18))),
                  const SizedBox(width: 6),
                  const Expanded(
                      child: Text('Student/Staff Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700))),
                ]),
                const SizedBox(height: 20),

                // logo box
                Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18)),
                    padding: const EdgeInsets.all(12),
                    child: Image.asset('assets/images/tracki_logo.jpg',
                        fit: BoxFit.contain,
                        errorBuilder: (c, e, s) => const SizedBox.shrink())),
                const SizedBox(height: 18),

                // white form card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14)),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Welcome Back!',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 6),
                        const Text('Enter your college credentials to continue',
                            style: TextStyle(color: Colors.black54)),
                        const SizedBox(height: 18),

                        // Name field (new)
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Student Name',
                              prefixIcon: const Icon(Icons.person_outline),
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none)),
                          validator: (v) => (v == null || v.trim().isEmpty)
                              ? 'Enter your name'
                              : null,
                          onSaved: (v) => name = v?.trim(),
                        ),
                        const SizedBox(height: 12),

                        // Email
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Email ID',
                              prefixIcon:
                                  const Icon(Icons.alternate_email_outlined),
                              hintText: 'Enter your college email',
                              filled: true,
                              fillColor: Colors.grey[100],
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none)),
                          keyboardType: TextInputType.emailAddress,
                          validator: (v) {
                            if (v == null || v.trim().isEmpty) {
                              return 'Enter email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
                              return 'Enter valid email';
                            }
                            return null;
                          },
                          onSaved: (v) => email = v?.trim(),
                        ),
                        const SizedBox(height: 12),

                        // Password
                        TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              filled: true,
                              fillColor: Colors.grey[100],
                              suffixIcon: IconButton(
                                  icon: Icon(_obscure
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () =>
                                      setState(() => _obscure = !_obscure)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none)),
                          obscureText: _obscure,
                          validator: (v) => (v == null || v.length < 6)
                              ? 'Password min 6 chars'
                              : null,
                          onSaved: (v) => password = v,
                        ),
                        const SizedBox(height: 8),

                        Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () => Navigator.pushNamed(
                                    context, '/forgot_password'),
                                child: const Text('Forgot password?',
                                    style: TextStyle(color: Colors.blue)))),
                        const SizedBox(height: 8),

                        // Login -> pass name to student_details
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              final f = _formKey.currentState!;
                              if (f.validate()) {
                                f.save();
                                // navigate to StudentDetails and pass student name
                                Navigator.pushReplacementNamed(
                                    context, '/student_details',
                                    arguments: {
                                      'studentName': name ?? '',
                                    });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            child: Ink(
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      Color(0xFF7C4DFF),
                                      Color(0xFF536DFE)
                                    ]),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Container(
                                    alignment: Alignment.center,
                                    height: 46,
                                    child: const Text('Login',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700)))),
                          ),
                        ),

                        const SizedBox(height: 12),
                        const Row(children: [
                          Expanded(child: Divider()),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text('or')),
                          Expanded(child: Divider())
                        ]),
                        const SizedBox(height: 12),

                        // Google sign in UI
                        SizedBox(
                            width: double.infinity,
                            child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                icon: Image.asset(
                                    'assets/images/tracki_logo.jpg',
                                    width: 20,
                                    height: 20,
                                    errorBuilder: (c, e, s) =>
                                        const SizedBox.shrink()),
                                label: const Text('Sign in with Google'),
                                onPressed: () => ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                        content: Text(
                                            'Google sign-in not implemented'))))),
                        const SizedBox(height: 14),

                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account? "),
                              GestureDetector(
                                  onTap: () => Navigator.pushNamed(
                                          context, '/student_details',
                                          arguments: {
                                            'studentName': 'New Student'
                                          }),
                                  child: const Text('Register',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w600)))
                            ])
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
