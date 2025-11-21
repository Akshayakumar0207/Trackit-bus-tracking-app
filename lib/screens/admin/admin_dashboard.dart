// lib/screens/admin/admin_dashboard.dart
import 'package:flutter/material.dart';
import 'add_bus_dialog.dart';
import 'generate_report.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  // initial sample buses
  final List<Map<String, dynamic>> _buses = [
    {
      'busNumber': 'TN45-2341',
      'route': 'Salem',
      'status': 'Active',
      'students': 45,
      'driver': 'Rajesh Kumar'
    },
    {
      'busNumber': 'TN45-2342',
      'route': 'Erode',
      'status': 'Idle',
      'students': 38,
      'driver': 'Suresh Babu'
    },
    {
      'busNumber': 'TN45-2343',
      'route': 'Namakkal',
      'status': 'Maintenance',
      'students': 42,
      'driver': 'Murugan'
    },
  ];

  final List<Map<String, String>> _drivers = [
    {'name': 'Rajesh Kumar', 'phone': '+91 98765 43210', 'bus': 'TN45-2341'},
    {'name': 'Suresh Babu', 'phone': '+91 98765 43211', 'bus': 'TN45-2342'},
  ];

  final List<Map<String, String>> _students = [
    {'name': 'Priya Sharma', 'email': 'priya@college.edu', 'bus': 'TN45-2341'},
    {'name': 'Arjun Patel', 'email': 'arjun@college.edu', 'bus': 'TN45-2342'},
  ];

  int _selectedTab = 1; // 1 = Bus Management

  Future<void> _openAddBus() async {
    final result = await showDialog(
        context: context, builder: (_) => const AddBusDialog());
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _buses.insert(0, {
          'busNumber': result['busNumber'],
          'route': result['route'],
          'status': 'Idle',
          'students': result['students'],
          'driver': 'Unassigned'
        });
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('New bus added')));
    }
  }

  Widget _statusChip(String status) {
    Color bg;
    if (status.toLowerCase() == 'active')
      bg = Colors.green.shade300;
    else if (status.toLowerCase() == 'maintenance')
      bg = Colors.red.shade200;
    else
      bg = Colors.grey.shade300;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration:
          BoxDecoration(color: bg, borderRadius: BorderRadius.circular(12)),
      child: Text(status, style: const TextStyle(fontWeight: FontWeight.w700)),
    );
  }

  Widget _busCard(Map<String, dynamic> b) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [Color(0xFF7C4DFF), Color(0xFF536DFE)]),
              borderRadius: BorderRadius.circular(10)),
          child: const Icon(Icons.directions_bus, color: Colors.white),
        ),
        title: Text(b['busNumber'],
            style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(
            'Route: ${b['route']} • Driver: ${b['driver']}\n${b['students']} students registered'),
        isThreeLine: true,
        trailing: _statusChip(b['status']),
      ),
    );
  }

  Widget _equalBox(String title, IconData icon, Color start, Color end) {
    return Container(
      constraints: const BoxConstraints(minHeight: 110),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 8, offset: Offset(0, 6))
          ]),
      child: Row(
        children: [
          Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [start, end]),
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: Colors.white)),
          const SizedBox(width: 12),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 6),
                const Text('Details')
              ]))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final gradientButton = BoxDecoration(
        gradient: const LinearGradient(
            colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)]),
        borderRadius: BorderRadius.circular(12));

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7FB),
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        backgroundColor: const Color(0xFFFF5F7A),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Column(
            children: [
              // header top
              Row(children: [
                Expanded(
                    child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Color(0xFFFF7A95), Color(0xFFFF5F7A)]),
                            borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                        child: Row(children: const [
                          Icon(Icons.settings, color: Colors.white),
                          SizedBox(width: 12),
                          Expanded(
                              child: Text('Admin Dashboard',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800)))
                        ]))),
                const SizedBox(width: 12),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const GenerateReportPage()));
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: gradientButton,
                    child: const Text('Generate Reports',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700)),
                  ),
                )
              ]),
              const SizedBox(height: 18),

              // tabs row
              Row(children: [
                _tabButton('Overview', 0, Colors.blue, Colors.indigo),
                const SizedBox(width: 8),
                _tabButton('Bus Management', 1, Colors.purple, Colors.pink),
                const SizedBox(width: 8),
                _tabButton('Driver Management', 2, Colors.teal, Colors.green),
                const SizedBox(width: 8),
                _tabButton(
                    'Student Management', 3, Colors.orange, Colors.deepOrange),
              ]),
              const SizedBox(height: 16),

              // content
              if (_selectedTab == 0) ...[
                // Overview: equal boxes grid (2 columns)
                GridView.count(
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 900 ? 3 : 1,
                  shrinkWrap: true,
                  childAspectRatio: 3.6,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _equalBox('Total Buses', Icons.directions_bus,
                        const Color(0xFF7C4DFF), const Color(0xFF536DFE)),
                    _equalBox('Active Buses', Icons.check_circle,
                        const Color(0xFF1BBF6A), const Color(0xFF0FB6A0)),
                    _equalBox('Maintenance', Icons.build,
                        const Color(0xFFF45C43), const Color(0xFFEB3349)),
                  ],
                )
              ] else if (_selectedTab == 1) ...[
                // Bus management header + add new bus
                Row(children: [
                  const Expanded(
                      child: Text('Bus Management',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800))),
                  ElevatedButton.icon(
                    onPressed: _openAddBus,
                    icon: const Icon(Icons.add),
                    label: const Text('Add New Bus'),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        backgroundColor: const Color(0xFF7C4DFF)),
                  )
                ]),
                const SizedBox(height: 12),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _buses.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => _busCard(_buses[i]),
                ),
              ] else if (_selectedTab == 2) ...[
                Row(children: [
                  const Expanded(
                      child: Text('Driver Management',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800))),
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person_add),
                      label: const Text('Add New Driver'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green))
                ]),
                const SizedBox(height: 12),
                ..._drivers
                    .map((d) => Card(
                        child: ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(d['name']!),
                            subtitle: Text('${d['bus']} • ${d['phone']}'))))
                    .toList()
              ] else ...[
                Row(children: [
                  const Expanded(
                      child: Text('Student Management',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800))),
                  ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.person_add_alt_1),
                      label: const Text('Add New Student'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple))
                ]),
                const SizedBox(height: 12),
                ..._students
                    .map((s) => Card(
                        child: ListTile(
                            leading: const Icon(Icons.school),
                            title: Text(s['name']!),
                            subtitle: Text('${s['email']} • ${s['bus']}'))))
                    .toList()
              ],
              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabButton(String title, int idx, Color a, Color b) {
    final selected = _selectedTab == idx;
    return InkWell(
      onTap: () => setState(() => _selectedTab = idx),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          gradient: selected ? LinearGradient(colors: [a, b]) : null,
          color: selected ? null : Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: selected
              ? [
                  BoxShadow(
                      color: a.withOpacity(0.22),
                      blurRadius: 12,
                      offset: const Offset(0, 6))
                ]
              : [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Text(title,
            style: TextStyle(
                color: selected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w700)),
      ),
    );
  }
}
