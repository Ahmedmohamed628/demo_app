import 'package:flutter/material.dart';

class CharacterDetailsScreen extends StatelessWidget {
  const CharacterDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Character Details'), centerTitle: true),
      body: Center(child: Text('Character Details Screen')),
    );
  }
}
