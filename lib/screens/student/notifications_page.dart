// lib/screens/notifications_page.dart
import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final List<Map<String, String>> _notifications = [
    {'title': 'Demo', 'body': 'Driver is 2 min away'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Notifications'),
          backgroundColor: const Color(0xFF536DFE)),
      body: _notifications.isEmpty
          ? const Center(child: Text('No notifications yet'))
          : ListView.builder(
              itemCount: _notifications.length,
              itemBuilder: (ctx, i) {
                final n = _notifications[i];
                return ListTile(
                  title: Text(n['title'] ?? ''),
                  subtitle: Text(n['body'] ?? ''),
                  leading: const Icon(Icons.notifications),
                );
              },
            ),
    );
  }
}
