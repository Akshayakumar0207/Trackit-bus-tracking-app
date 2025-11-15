import 'package:flutter/material.dart';

// Simple in-memory bus model
class BusItem {
  String number;
  String route;
  String driver;
  String status;
  BusItem(
      {required this.number,
      required this.route,
      required this.driver,
      this.status = 'ACTIVE'});
}

class BusManagementPage extends StatefulWidget {
  const BusManagementPage({Key? key}) : super(key: key);
  @override
  State<BusManagementPage> createState() => _BusManagementPageState();
}

class _BusManagementPageState extends State<BusManagementPage> {
  List<BusItem> buses = [
    BusItem(
        number: 'TN45-2341',
        route: 'Salem - College',
        driver: 'Rajesh Kumar',
        status: 'ACTIVE'),
    BusItem(
        number: 'TN45-2342',
        route: 'Erode - College',
        driver: 'Suresh Babu',
        status: 'IDLE'),
    BusItem(
        number: 'TN45-2343',
        route: 'Namakkal - College',
        driver: 'Murugan',
        status: 'MAINTENANCE'),
  ];

  void _onAdd() async {
    await Navigator.pushNamed(context, '/add_driver');
    setState(() {}); // refresh in demo (in-memory)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Bus Management'),
          backgroundColor: Colors.pinkAccent),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Bus Management',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            ElevatedButton(
                onPressed: _onAdd,
                child: const Text('+ Add New Driver'),
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.indigo)),
          ]),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: buses.length,
              itemBuilder: (context, i) {
                final b = buses[i];
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
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
                  child: Row(children: [
                    Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                            color: Colors.purple.shade100,
                            borderRadius: BorderRadius.circular(8)),
                        child: const Icon(Icons.directions_bus,
                            color: Colors.white)),
                    const SizedBox(width: 12),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Text(b.number,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w800)),
                          Text('Route: ${b.route} • Driver: ${b.driver}',
                              style: const TextStyle(color: Colors.black54))
                        ])),
                    const SizedBox(width: 8),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                            color: b.status == 'ACTIVE'
                                ? Colors.green.shade100
                                : Colors.orange.shade100,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(b.status,
                            style:
                                const TextStyle(fontWeight: FontWeight.w700))),
                    const SizedBox(width: 8),
                    PopupMenuButton<String>(
                        onSelected: (s) {
                          if (s == 'edit') {}
                        },
                        itemBuilder: (_) => [
                              const PopupMenuItem(
                                  value: 'edit', child: Text('Edit')),
                              const PopupMenuItem(
                                  value: 'remove', child: Text('Remove'))
                            ])
                  ]),
                );
              },
            ),
          )
        ]),
      ),
    );
  }
}
