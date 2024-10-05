import 'package:flutter/material.dart';

class DizimosScreen extends StatefulWidget {
  @override
  _DizimosScreenState createState() => _DizimosScreenState();
}

class _DizimosScreenState extends State<DizimosScreen> {
  final List<double> valoresDizimos = [];
  double totalDizimos = 0.0;

  void _showDizimoDialog() {
    final valorController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Cadastrar Dízimo'),
          content: TextField(
            controller: valorController,
            decoration: InputDecoration(labelText: 'Valor do Dízimo'),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              onPressed: () {
                final valor = double.tryParse(valorController.text);
                if (valor != null) {
                  setState(() {
                    valoresDizimos.add(valor);
                    totalDizimos += valor;
                  });
                  Navigator.of(context).pop();
                }
              },
              child: Text('Adicionar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dízimos'),
        backgroundColor: Colors.blue[800],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total de Dízimos',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'R\$ ${totalDizimos.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 24, color: Colors.green),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showDizimoDialog,
              child: Text('Cadastrar Dízimo'),
            ),
            SizedBox(height: 20),
            Text(
              'Últimos Dízimos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: valoresDizimos.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text('Dízimo: R\$ ${valoresDizimos[index].toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aqui você pode implementar a lógica para puxar um relatório de dizimistas
                // ou navegar para outra tela
              },
              child: Text('Puxar Relatório de Dízimistas'),
            ),
          ],
        ),
      ),
    );
  }
}
