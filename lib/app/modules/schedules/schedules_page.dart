import 'package:flutter/material.dart';

class SchedulesPage extends StatefulWidget {

  const SchedulesPage({ super.key });

  @override
  State<SchedulesPage> createState() => _SchedulesPageState();
}

class _SchedulesPageState extends State<SchedulesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Schedules',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
      body: Container(),
    );
  }
}