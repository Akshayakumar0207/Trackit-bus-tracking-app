// lib/screens/student_dashboard.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  static const Map<String, Map<String, String>> _driverInfo = {
    'B112': {'driver': 'Ramesh K', 'contact': '+91 9363151370'},
    'B113': {'driver': 'Suresh P', 'contact': '+91 98765 00002'},
    'B88': {'driver': 'Meena S', 'contact': '+91 9363151370'},
    // ... others
  };

  Future<void> _callNumber(String number) async {
    final uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _sendSms(String number, String body) async {
    final uri = Uri.parse('sms:$number?body=${Uri.encodeComponent(body)}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final String studentName = args?['studentName'] ?? 'Student';
    final String busNumber = args?['busNumber'] ?? 'B112';
    final String route = args?['route'] ?? 'Salem';
    final String boarding = args?['boardingStop'] ?? '';

    final driver = _driverInfo[busNumber]?['driver'] ?? 'Driver';
    final contact = _driverInfo[busNumber]?['contact'] ?? '+91 9363151370';

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xFF5A6BFF), Color(0xFFB23CFF)]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Icon(Icons.school, color: Colors.white)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          const Text('Welcome',
                              style: TextStyle(color: Colors.white70)),
                          const SizedBox(height: 4),
                          Text(studentName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800))
                        ])),
                    IconButton(
                      onPressed: () {
                        // go to Notifications page
                        Navigator.pushNamed(context, '/notifications');
                      },
                      icon:
                          const Icon(Icons.notifications, color: Colors.white),
                    ),
                    const SizedBox(width: 6),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            '/login', (route) => false);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white24,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8))),
                      child: const Text('Logout',
                          style: TextStyle(color: Colors.white)),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // tracking card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 6))
                    ]),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Your Bus',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 10),
                      Text('Bus Number: $busNumber',
                          style: const TextStyle(fontWeight: FontWeight.w700)),
                      const SizedBox(height: 6),
                      Text('Driver: $driver'),
                      const SizedBox(height: 6),
                      Text('Contact: $contact'),
                      const SizedBox(height: 14),
                      Row(children: [
                        Expanded(
                            child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(colors: [
                                      Color(0xFF8E2DE2),
                                      Color(0xFF4A00E0)
                                    ]),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        borderRadius: BorderRadius.circular(8),
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/tracking', arguments: {
                                            'busNumber': busNumber
                                          });
                                        },
                                        child: const Center(
                                            child: Text('Track My Bus',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700))))))),
                        const SizedBox(width: 12),
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () async {
                                  /* enable notifications UI */
                                },
                                child: const Text('Enable Notifications'))),
                      ]),
                      const SizedBox(height: 12),
                      Row(children: [
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () => _callNumber(contact),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green),
                                child: const Text('Call Driver'))),
                        const SizedBox(width: 12),
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () =>
                                    _sendSms(contact, 'where is the bus'),
                                child: const Text('Message Driver'))),
                      ]),
                    ]),
              ),

              const SizedBox(height: 18),

              // simple next stops / details area (static)
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: Offset(0, 6))
                      ]),
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Next Stops',
                            style: TextStyle(fontWeight: FontWeight.w700)),
                        SizedBox(height: 10),
                        Text('• Main Gate  - 2 min'),
                        SizedBox(height: 6),
                        Text('• Library Block - 8 min'),
                        SizedBox(height: 6),
                        Text('• Hostel Block A - 15 min')
                      ])),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
