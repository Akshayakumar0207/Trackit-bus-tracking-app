import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  Widget _card(String title, String value, Color start, Color end,
      {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [start, end]),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: [
        if (icon != null)
          Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: Colors.white)),
        const SizedBox(width: 12),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 18))
        ])
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          // header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: const Color(0xFFFF7A95),
                borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              const CircleAvatar(
                  radius: 24,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.settings, color: Colors.white)),
              const SizedBox(width: 12),
              const Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text('Admin Dashboard',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800)),
                    SizedBox(height: 4),
                    Text('Complete system control & management',
                        style: TextStyle(color: Colors.white70))
                  ])),
              IconButton(
                  onPressed: () {
                    /* logout */ Navigator.pushReplacementNamed(
                        context, '/admin_login');
                  },
                  icon: const Icon(Icons.logout, color: Colors.white)),
            ]),
          ),
          const SizedBox(height: 14),
          Row(children: [
            Expanded(
                child: _card(
                    'Total Buses', '4', Color(0xFF7C4DFF), Color(0xFF536DFE),
                    icon: Icons.directions_bus)),
            const SizedBox(width: 12),
            Expanded(
                child: _card(
                    'Active Buses', '2', Color(0xFF1BBF6A), Color(0xFF1BBF6A),
                    icon: Icons.check_circle))
          ]),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(
                child: _card(
                    'Total Drivers', '4', Color(0xFFFF8A00), Color(0xFFFF4D4D),
                    icon: Icons.person)),
            const SizedBox(width: 12),
            Expanded(
                child: _card('Total Students', '120', Color(0xFF8E24AA),
                    Color(0xFF536DFE),
                    icon: Icons.school))
          ]),
          const SizedBox(height: 18),

          // recent activity card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Recent Activity',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              _activityRow(
                  Colors.green, 'Bus TN45-2341 started journey at 8:30 AM'),
              _activityRow(Colors.blue, 'New student Priya Sharma registered'),
              _activityRow(
                  Colors.orange, 'Bus TN45-2343 scheduled for maintenance'),
            ]),
          ),

          const SizedBox(height: 18),
          // navigation buttons
          Wrap(spacing: 12, runSpacing: 12, children: [
            _navTile(context, 'Bus Management', Icons.directions_bus,
                '/bus_management'),
            _navTile(context, 'Driver Management', Icons.person,
                '/bus_management'), // reuse bus mgmt page for demo
            _navTile(context, 'Student Management', Icons.school,
                '/student_management'),
            _navTile(
                context, 'System Settings', Icons.settings, '/system_settings'),
            _navTile(context, 'Export Data', Icons.download, '/export'),
            _navTile(context, 'Generate Reports', Icons.insert_chart,
                '/generate_report'),
          ])
        ]),
      )),
    );
  }

  Widget _activityRow(Color dot, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(children: [
        Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: dot, shape: BoxShape.circle)),
        const SizedBox(width: 10),
        Expanded(child: Text(text)),
      ]),
    );
  }

  Widget _navTile(BuildContext c, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(c, route),
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black12, blurRadius: 8, offset: Offset(0, 6))
            ]),
        child: Row(children: [
          Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                  color: Colors.pink.shade100,
                  borderRadius: BorderRadius.circular(8)),
              child: Icon(icon, color: Colors.white)),
          const SizedBox(width: 8),
          Expanded(
              child: Text(title,
                  style: const TextStyle(fontWeight: FontWeight.w700)))
        ]),
      ),
    );
  }
}
