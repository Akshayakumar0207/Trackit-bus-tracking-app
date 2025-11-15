// lib/screens/tracking_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();
  bool _isActive = false; // idle or active
  LatLng _busPos = const LatLng(11.6643, 78.1460); // sample initial

  // In real app listen to backend stream & update _busPos and _isActive
  Timer? _mockTimer;

  @override
  void initState() {
    super.initState();
    // Demo: after 5s set active and move position (simulate driver started)
    _mockTimer = Timer(const Duration(seconds: 5), () {
      setState(() {
        _isActive = true;
        _busPos = LatLng(_busPos.latitude + 0.0015, _busPos.longitude + 0.0015);
      });
    });
  }

  @override
  void dispose() {
    _mockTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final busNumber = args?['busNumber'] ?? 'B117';

    return Scaffold(
      appBar: AppBar(
          title: Text('Bus $busNumber'),
          backgroundColor: const Color(0xFF536DFE)),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: _busPos, zoom: 15),
              markers: {
                Marker(
                    markerId: const MarkerId('bus'),
                    position: _busPos,
                    infoWindow: InfoWindow(title: 'Bus $busNumber'))
              },
              onMapCreated: (GoogleMapController c) {
                if (!_controller.isCompleted) _controller.complete(c);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                    child: Text(_isActive ? 'Status: Active' : 'Status: Idle',
                        style: const TextStyle(fontWeight: FontWeight.w700))),
                TextButton.icon(
                    onPressed: () async {
                      // center map on bus
                      final ctrl = await _controller.future;
                      await ctrl.animateCamera(CameraUpdate.newLatLng(_busPos));
                    },
                    icon: const Icon(Icons.my_location),
                    label: const Text('Center')),
              ],
            ),
          )
        ],
      ),
    );
  }
}
