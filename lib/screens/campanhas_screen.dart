// lib/screens/campanhas_screen.dart
import 'package:flutter/material.dart';

class CampanhasScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campanhas'),
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child: Text(
          'Aqui estão suas campanhas!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
