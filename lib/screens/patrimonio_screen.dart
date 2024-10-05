// lib/screens/patrimonio_screen.dart
import 'package:flutter/material.dart';

class PatrimonioScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patrimônio'),
        backgroundColor: Colors.green[800],
      ),
      body: Center(
        child: Text(
          'Aqui está a seção de Patrimônio!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
