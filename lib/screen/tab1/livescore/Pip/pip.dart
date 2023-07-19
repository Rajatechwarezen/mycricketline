import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Pip extends StatefulWidget {
  const Pip({super.key});

  @override
  State<Pip> createState() => _PipState();
}

class _PipState extends State<Pip> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PIP Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
