import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:csv/csv.dart';

// Only import dart:html on web
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class GenerateReportPage extends StatelessWidget {
  const GenerateReportPage({Key? key}) : super(key: key);

  void _downloadReport(BuildContext c) {
    final rows = [
      ['Metric', 'Value'],
      ['Active Buses', '2'],
      ['Total Students', '120']
    ];

    final csv = const ListToCsvConverter().convert(rows);

    // WEB EXPORT
    if (kIsWeb) {
      final bytes = utf8.encode(csv);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);

      final a = html.AnchorElement(href: url)
        ..setAttribute('download', 'report.csv')
        ..click();

      html.Url.revokeObjectUrl(url);
      return;
    }

    // MOBILE / WINDOWS MESSAGE
    ScaffoldMessenger.of(c).showSnackBar(
      const SnackBar(
        content: Text('CSV download is only available on Web version.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Generate Reports')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'Overview',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 12),
            Card(
                child: ListTile(
                    title: const Text('Active Buses'),
                    trailing: const Text('2'))),
            Card(
                child: ListTile(
                    title: const Text('Total Students'),
                    trailing: const Text('120'))),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _downloadReport(context),
              child: const Text('Download Report (CSV)'),
            ),
          ],
        ),
      ),
    );
  }
}
