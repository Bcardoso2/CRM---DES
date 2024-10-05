import 'package:admin/constants.dart';
import 'package:flutter/material.dart';

class FinanceiroScreen extends StatefulWidget {
  @override
  _FinanceiroScreenState createState() => _FinanceiroScreenState();
}

class _FinanceiroScreenState extends State<FinanceiroScreen> {
  final List<Map<String, dynamic>> transacoes = [];
  final List<String> categorias = ['Alimentação', 'Combustível', 'Recorrentes', 'Obras'];
  String? selectedCommunity;
  String? transactionType = 'Receita';

  double get totalReceitas =>
      transacoes.where((t) => t['tipo'] == 'Receita').fold(0.0, (sum, t) => sum + t['valor']);
  
  double get totalDespesas =>
      transacoes.where((t) => t['tipo'] == 'Despesa').fold(0.0, (sum, t) => sum + t['valor']);

  void _showTransactionDialog() {
    final nomeController = TextEditingController();
    final valorController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Transação'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButton<String>(
                  hint: Text('Selecione o Tipo'),
                  value: transactionType,
                  onChanged: (newValue) {
                    setState(() {
                      transactionType = newValue;
                    });
                  },
                  items: ['Receita', 'Despesa'].map((tipo) {
                    return DropdownMenuItem(
                      value: tipo,
                      child: Text(tipo),
                    );
                  }).toList(),
                ),
                TextField(
                  controller: nomeController,
                  decoration: InputDecoration(labelText: 'Nome da Transação'),
                ),
                TextField(
                  controller: valorController,
                  decoration: InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.number,
                ),
                DropdownButton<String>(
                  hint: Text('Selecione a Comunidade'),
                  value: selectedCommunity,
                  onChanged: (newValue) {
                    setState(() {
                      selectedCommunity = newValue;
                    });
                  },
                  items: ['Matriz', 'Comunidade Belem', 'Comunidade São José', 'Comunidade Externa'].map((comunidade) {
                    return DropdownMenuItem(
                      child: Text(comunidade),
                      value: comunidade,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final nome = nomeController.text;
                final valor = double.tryParse(valorController.text);
                if (nome.isNotEmpty && valor != null && selectedCommunity != null) {
                  transacoes.add({
                    'nome': nome,
                    'valor': valor,
                    'comunidade': selectedCommunity,
                    'tipo': transactionType,
                  });
                  Navigator.of(context).pop();
                  setState(() {}); // Atualiza a tela
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
        title: Text('Financeiro'),
        backgroundColor: secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              hint: Text('Selecione a Comunidade'),
              value: selectedCommunity,
              onChanged: (newValue) {
                setState(() {
                  selectedCommunity = newValue;
                });
              },
              items: ['Matriz', 'Comunidade Belem', 'Comunidade São José', 'Comunidade Externa'].map((comunidade) {
                return DropdownMenuItem(
                  child: Text(comunidade),
                  value: comunidade,
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total de Receitas',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'R\$ ${totalReceitas.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 24, color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total de Despesas',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'R\$ ${totalDespesas.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 24, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showTransactionDialog,
              child: Text('Adicionar Transação'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: transacoes.length,
                itemBuilder: (context, index) {
                  final transacao = transacoes[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(transacao['nome']),
                      subtitle: Text(
                        'Tipo: ${transacao['tipo']} | Comunidade: ${transacao['comunidade']}',
                      ),
                      trailing: Text('R\$ ${transacao['valor'].toStringAsFixed(2)}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
