import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Widget _emojiBox(String emoji, {double size = 28}) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF7C4DFF), Color(0xFF536DFE)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          emoji,
          style: TextStyle(fontSize: size),
        ),
      ),
    );
  }

  Widget _choiceCard({
    required BuildContext context,
    required String emoji,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
                color: Colors.black12, blurRadius: 14, offset: Offset(0, 8)),
          ],
        ),
        child: Row(
          children: [
            _emojiBox(emoji),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16.6, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 13.2, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: const Color(0xFFEAF3FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.arrow_forward_ios,
                  color: Color(0xFF4A90E2), size: 16),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bgGradient = LinearGradient(
      colors: [Color(0xFF536DFE), Color(0xFF8E24AA)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: bgGradient),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 28),
              // top white rounded logo box — replaces bus icon with your logo
              Container(
                width: 88,
                height: 88,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 6))
                  ],
                ),
                padding: const EdgeInsets.all(12),
                child: Image.asset(
                  'assets/images/tracki_logo.jpg', // <- make sure this path & filename match
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    // fallback so tests / builds don't crash if asset missing
                    return const SizedBox.shrink();
                  },
                ),
              ),
              const SizedBox(height: 18),
              const Text(
                'Welcome Back!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose your login type to continue',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 22),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 6, bottom: 24),
                  children: [
                    _choiceCard(
                      context: context,
                      emoji: '🎓', // student/staff
                      title: 'Student/Staff\nLogin',
                      subtitle: 'Track your bus in real-time',
                      onTap: () {
                        // navigate to your student login form
                        Navigator.pushNamed(context, '/student_login');
                      },
                    ),
                    _choiceCard(
                      context: context,
                      emoji: '🚍', // driver/bus emoji
                      title: 'Driver Login',
                      subtitle: 'Start your journey and track routes',
                      onTap: () {
                        Navigator.pushNamed(context, '/driver_login');
                      },
                    ),
                    _choiceCard(
                      context: context,
                      emoji: '⚙️', // admin
                      title: 'Admin Login',
                      subtitle: 'Manage system and monitor all buses',
                      onTap: () {
                        Navigator.pushNamed(context, '/admin_login');
                      },
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
