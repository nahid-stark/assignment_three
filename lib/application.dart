import 'package:assignment_three/list_screen.dart';
import 'package:flutter/material.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
