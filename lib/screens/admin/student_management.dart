import 'package:flutter/material.dart';

class StudentManagementPage extends StatefulWidget {
  const StudentManagementPage({Key? key}) : super(key: key);

  @override
  State<StudentManagementPage> createState() => _StudentManagementPageState();
}

class _StudentManagementPageState extends State<StudentManagementPage> {
  final List<Map<String, String>> students = [
    {'name': 'Akshaya Kumar', 'email': 'akshu@college.edu', 'bus': 'B88'},
    {'name': 'Kavya Ananth', 'email': 'kavzz@college.edu', 'bus': 'B116'},
    {'name': 'Gopika Malar', 'email': 'gopika@college.edu', 'bus': 'B113'},
    {
      'name': 'Keerthana vishwanathan',
      'email': 'keerthi@college.edu',
      'bus': 'B161'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Student Management'),
          backgroundColor: Colors.pinkAccent),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Text('Student Management',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/add_student'),
                child: const Text('+ Add New Student'))
          ]),
          const SizedBox(height: 12),
          Expanded(
              child: ListView.builder(
            itemCount: students.length,
            itemBuilder: (c, i) {
              final s = students[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 8)
                    ]),
                child: Row(children: [
                  Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                          color: Colors.purple.shade100,
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.school, color: Colors.white)),
                  const SizedBox(width: 12),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(s['name']!,
                            style:
                                const TextStyle(fontWeight: FontWeight.w800)),
                        Text('${s['email']} • Bus: ${s['bus']}',
                            style: const TextStyle(color: Colors.black54))
                      ])),
                  PopupMenuButton(
                      itemBuilder: (_) => [
                            const PopupMenuItem(child: Text('Edit')),
                            const PopupMenuItem(child: Text('Remove'))
                          ])
                ]),
              );
            },
          ))
        ]),
      ),
    );
  }
}
