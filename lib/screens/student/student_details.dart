// lib/screens/student_details.dart
import 'package:flutter/material.dart';

class StudentDetails extends StatefulWidget {
  const StudentDetails({super.key});

  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  final _formKey = GlobalKey<FormState>();

  final List<String> _busNumbers = [
    'B112',
    'B113',
    'B88',
    'B171',
    'B116',
    'B157',
    'B2',
    'B161',
    'B162',
    'B13',
    'B44',
    'B107',
    'B108',
  ];

  final List<String> _routes = ['Salem', 'Erode', 'Rasipuram', 'Namakkal'];

  String? _selectedBus;
  String? _selectedRoute;
  final TextEditingController _boardingCtrl = TextEditingController();
  String studentName = 'Student';

  @override
  void initState() {
    super.initState();
    _selectedBus = _busNumbers.isNotEmpty ? _busNumbers.first : null;
    _selectedRoute = _routes.isNotEmpty ? _routes.first : null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['studentName'] != null) {
      studentName = args['studentName'] as String;
    }
  }

  @override
  void dispose() {
    _boardingCtrl.dispose();
    super.dispose();
  }

  void _onTrack() {
    final form = _formKey.currentState;
    if (form == null) return;
    if (!form.validate()) return;
    form.save();

    Navigator.pushNamed(
      context,
      '/student_dashboard',
      arguments: {
        'studentName': studentName,
        'busNumber': _selectedBus,
        'route': _selectedRoute,
        'boardingStop': _boardingCtrl.text.trim(),
      },
    );
  }

  Widget _activeBusCard(String title, String route, String status, String eta) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF1BBF6A),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
              color: Colors.black12, blurRadius: 10, offset: Offset(0, 6)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.directions_bus, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)),
                Text('Route: $route',
                    style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Row(
                children: [
                  Icon(Icons.circle, size: 10, color: Colors.white),
                  SizedBox(width: 6),
                  Text('Live', style: TextStyle(color: Colors.white)),
                ],
              ),
              Text(eta, style: const TextStyle(color: Colors.white70)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const headerGradient = LinearGradient(
      colors: [Color(0xFF536DFE), Color(0xFF8E24AA)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: headerGradient),
        child: SafeArea(
          child: Column(
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 12.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).maybePop(),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.arrow_back_ios,
                            color: Colors.white, size: 18),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Student Dashboard',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(Icons.logout, color: Colors.white),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      // Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 14,
                                offset: Offset(0, 8))
                          ],
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(colors: [
                                        Color(0xFF7C4DFF),
                                        Color(0xFF536DFE)
                                      ]),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(Icons.directions_bus,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text('Select Your Bus',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                ],
                              ),
                              const SizedBox(height: 16),
                              const Text('Bus Number',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                initialValue: _selectedBus,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none),
                                ),
                                items: _busNumbers
                                    .map((b) => DropdownMenuItem(
                                        value: b, child: Text(b)))
                                    .toList(),
                                onChanged: (v) =>
                                    setState(() => _selectedBus = v),
                                validator: (v) => (v == null || v.isEmpty)
                                    ? 'Please select bus'
                                    : null,
                                onSaved: (v) => _selectedBus = v,
                              ),
                              const SizedBox(height: 12),
                              const Text('Route',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8),
                              DropdownButtonFormField<String>(
                                initialValue: _selectedRoute,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none),
                                ),
                                items: _routes
                                    .map((r) => DropdownMenuItem(
                                        value: r, child: Text(r)))
                                    .toList(),
                                onChanged: (v) =>
                                    setState(() => _selectedRoute = v),
                                validator: (v) => (v == null || v.isEmpty)
                                    ? 'Please select route'
                                    : null,
                                onSaved: (v) => _selectedRoute = v,
                              ),
                              const SizedBox(height: 12),
                              const Text('Boarding Stop',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 8),
                              TextFormField(
                                controller: _boardingCtrl,
                                decoration: InputDecoration(
                                  hintText: 'Enter your boarding stop',
                                  prefixIcon:
                                      const Icon(Icons.location_on_outlined),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: BorderSide.none),
                                ),
                                validator: (v) =>
                                    (v == null || v.trim().isEmpty)
                                        ? 'Enter boarding stop'
                                        : null,
                                onSaved: (v) =>
                                    _boardingCtrl.text = v?.trim() ?? '',
                              ),
                              const SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                height: 48,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(colors: [
                                    Color(0xFF7C4DFF),
                                    Color(0xFF536DFE)
                                  ]),
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: const [
                                    BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 8,
                                        offset: Offset(0, 6))
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: _onTrack,
                                    child: const Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.place_outlined,
                                              color: Colors.white),
                                          SizedBox(width: 8),
                                          Text('Track My Bus',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 16)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Text('Active Buses',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w700)),
                        ),
                      ),
                      const SizedBox(height: 6),
                      _activeBusCard(
                          'Bus B88', 'Salem', 'Live', 'ETA: 1 hr 15 min'),
                      const SizedBox(height: 12),
                      _activeBusCard(
                          'Bus B106', 'Erode', 'Live', 'ETA: 1 hr 30 min'),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
