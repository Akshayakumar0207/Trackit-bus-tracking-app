import 'package:flutter/material.dart';

class SystemSettingsPage extends StatelessWidget {
  const SystemSettingsPage({Key? key}) : super(key: key);

  void _alterBus(BuildContext c) {
    // demo: show snackbar
    ScaffoldMessenger.of(c).showSnackBar(
        const SnackBar(content: Text('Open Alter Bus screen (demo)')));
  }

  void _backupSystem(BuildContext c) {
    ScaffoldMessenger.of(c)
        .showSnackBar(const SnackBar(content: Text('Backup created (demo)')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('System Settings'),
          backgroundColor: Colors.pinkAccent),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          _card(
              context,
              'Bus Alteration',
              'Manage bus alterations and route changes',
              'Alter Bus Routes',
              () => _alterBus(context)),
          const SizedBox(height: 12),
          _card(
              context,
              'System Updates',
              'Manage system-wide updates and notifications',
              'System Backup',
              () => _backupSystem(context)),
          const SizedBox(height: 12),
          _card(context, 'Data Management', 'Export and manage all system data',
              'Export Data', () => Navigator.pushNamed(context, '/export')),
        ]),
      ),
    );
  }

  Widget _card(BuildContext c, String title, String subtitle,
      String actionLabel, VoidCallback onTap) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 8)]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        Text(subtitle, style: const TextStyle(color: Colors.black54)),
        const SizedBox(height: 12),
        ElevatedButton(onPressed: onTap, child: Text(actionLabel))
      ]),
    );
  }
}
