import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';
import 'dart:html' as html; // web only - wrapped with kIsWeb

class ExportPage extends StatelessWidget {
  const ExportPage({Key? key}) : super(key: key);

  void _exportCsv(BuildContext context) {
    // sample data
    final rows = [
      ['Bus', 'Driver', 'Status', 'Route'],
      ['TN45-2341', 'Rajesh Kumar', 'ACTIVE', 'Salem - College'],
      ['TN45-2342', 'Suresh B', 'IDLE', 'Erode - College'],
    ];
    final csv = const ListToCsvConverter().convert(rows);

    if (kIsWeb) {
      final bytes = utf8.encode(csv);
      final blob = html.Blob([bytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.AnchorElement(href: url)
        ..setAttribute('download', 'trackit_export.csv')
        ..click();
      html.Url.revokeObjectUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('CSV export only supported in web demo.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Export Data'), backgroundColor: Colors.teal),
      body: Center(
          child: ElevatedButton(
              onPressed: () => _exportCsv(context),
              child: const Text('Export CSV (web demo)'))),
    );
  }
}
