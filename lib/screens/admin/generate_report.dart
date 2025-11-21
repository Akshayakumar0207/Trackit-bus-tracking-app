// lib/screens/admin/generate_report.dart
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:csv/csv.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class GenerateReportPage extends StatelessWidget {
  const GenerateReportPage({Key? key}) : super(key: key);

  void _downloadCSV(BuildContext ctx) {
    final rows = [
      ['Metric', 'Value'],
      ['Active Buses', '20'],
      ['Maintenance', '4'],
      ['No. of Students', '600'],
      ['Staffs', '120'],
      ['Drivers', '30'],
    ];
    final csv = const ListToCsvConverter().convert(rows);
    if (kIsWeb) {
      final bytes = utf8.encode(csv);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final a = html.AnchorElement(href: url)
        ..setAttribute('download', 'trackit_report.csv')
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('CSV download available on Web only')));
    }
  }

  Widget _animatedStat(String label, int value, Color start, Color end) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.toDouble()),
      duration: const Duration(seconds: 2),
      builder: (context, val, child) {
        return Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Container(
            padding: const EdgeInsets.all(16),
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [start, end]),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.bar_chart, color: Colors.white)),
                const SizedBox(height: 10),
                Text(label,
                    style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(val.toInt().toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w900)),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Generate Reports'),
          backgroundColor: const Color(0xFF8E2DE2)),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Wrap(spacing: 12, runSpacing: 12, children: [
              _animatedStat('Active Buses', 20, const Color(0xFF7C4DFF),
                  const Color(0xFF536DFE)),
              _animatedStat('Maintenance', 4, const Color(0xFFF45C43),
                  const Color(0xFFEB3349)),
              _animatedStat('Students', 600, const Color(0xFF1BBF6A),
                  const Color(0xFF0FB6A0)),
              _animatedStat('Staffs', 120, const Color(0xFFFFC371),
                  const Color(0xFFFF5F7A)),
              _animatedStat('Drivers', 30, const Color(0xFF4A00E0),
                  const Color(0xFF8E2DE2)),
            ]),
            const SizedBox(height: 20),
            // decorative unique export button
            GestureDetector(
              onTap: () => _downloadCSV(context),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 1.0, end: 1.0),
                duration: const Duration(milliseconds: 600),
                builder: (context, v, child) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFF8E2DE2), Color(0xFF4A00E0)]),
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 18,
                            offset: const Offset(0, 10))
                      ],
                    ),
                    child: Row(mainAxisSize: MainAxisSize.min, children: const [
                      Icon(Icons.download, color: Colors.white),
                      SizedBox(width: 12),
                      Text('Download CSV',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800)),
                    ]),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
