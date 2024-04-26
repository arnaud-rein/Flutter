import 'package:flutter/material.dart';

class About extends StatelessWidget {
  const About({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('À propos', style: TextStyle(color: Colors.white)),
        ),
        body: const Center(
          child: Text("À propos"),
        ));
  }
}

