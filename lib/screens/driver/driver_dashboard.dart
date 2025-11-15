// lib/screens/driver_dashboard.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:geolocator/geolocator.dart'; // optional for real device location
// import 'package:cloud_firestore/cloud_firestore.dart'; // optional for realtime

class DriverDashboard extends StatefulWidget {
  const DriverDashboard({super.key});

  @override
  State<DriverDashboard> createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  bool _isActive = false;
  Timer? _mockTimer;
  double _lat = 11.6643, _lng = 78.1460; // demo start pos

  String driverName = 'Driver';
  String busNumber = 'B112';
  String driverId = 'driver112';

  @override
  void dispose() {
    _mockTimer?.cancel();
    super.dispose();
  }

  void _startRide() {
    setState(() => _isActive = true);
    // If you want real location, request permission & use Geolocator:
    // Geolocator.getPositionStream(...).listen((pos) { upload pos to firestore; });

    // Demo: start a timer to simulate movement and (optionally) write to backend
    _mockTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      setState(() {
        _lat += 0.0008; // move a bit
        _lng += 0.0006;
      });
      // TODO: upload to backend / firestore:
      // FirebaseFirestore.instance.collection('buses').doc(busNumber).set({
      //   'lat': _lat, 'lng': _lng, 'active': true, 'driver': driverName, 'timestamp': FieldValue.serverTimestamp()
      // }, SetOptions(merge: true));
    });
  }

  void _endRide() {
    _mockTimer?.cancel();
    setState(() => _isActive = false);
    // TODO: update backend doc active=false
  }

  Future<void> _call(String number) async {
    final uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      driverName = args['driverName'] ?? driverName;
      busNumber = args['busNumber'] ?? busNumber;
      driverId = args['driverId'] ?? driverId;
    }

    // demo driver contact
    const driverContact = '+91 9363151370';

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF12c2e9), Color(0xFFc471ed)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.drive_eta, color: Colors.white),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Driver Dashboard',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          driverName,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/alter_bus',
                      arguments: {'busNumber': busNumber},
                    ),
                    icon: const Icon(Icons.swap_horiz, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Card(
                elevation: 6,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.lightGreen[50],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.directions_bus,
                              color: Colors.green,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bus $busNumber',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  'Route: Salem - College',
                                  style: TextStyle(color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: _isActive
                                  ? Colors.green[100]
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              _isActive ? 'ACTIVE' : 'IDLE',
                              style: TextStyle(
                                color: _isActive
                                    ? Colors.green[800]
                                    : Colors.black54,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: _isActive ? _endRide : _startRide,
                              icon: Icon(
                                _isActive ? Icons.stop : Icons.play_arrow,
                              ),
                              label: Text(
                                _isActive ? 'End Ride' : 'Start Ride',
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    _isActive ? Colors.red : Colors.green,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          OutlinedButton(
                            onPressed: () => Navigator.pushNamed(
                              context,
                              '/alter_bus',
                              arguments: {'busNumber': busNumber},
                            ),
                            child: const Text('Alter Bus'),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () => _call(driverContact),
                              icon: const Icon(Icons.call),
                              label: const Text('Call Support'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),
            // Live GPS block (visual)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 36,
                        color: Colors.green,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isActive
                            ? 'Live GPS Tracking\nYour location is being shared'
                            : 'Live GPS Tracking\nIdle — start ride to share location',
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Lat: ${_lat.toStringAsFixed(5)}, Lng: ${_lng.toStringAsFixed(5)}',
                        style: const TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
