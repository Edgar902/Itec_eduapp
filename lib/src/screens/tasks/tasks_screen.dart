// Suggested code may be subject to a license. Learn more: ~LicenseLog:2607777393.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:369928224.
import 'package:flutter/material.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: const Center(
        child: Text('Tasks Screen'),
      ),
    );
  }
}