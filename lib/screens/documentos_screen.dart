import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class DocumentosScreen extends StatelessWidget {
  final List<Map<String, String>> documentos = [];
  final List<String> categorias = ['Pastoral', 'Tipo A', 'Tipo B'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documentos'),
        backgroundColor: const Color.fromARGB(255, 33, 35, 50),
      ),
      body: DefaultTabController(
        length: categorias.length,
        child: Column(
          children: [
            TabBar(
              tabs: categorias.map((categoria) => Tab(text: categoria)).toList(),
            ),
            Expanded(
              child: TabBarView(
                children: categorias.map((categoria) => _buildDocumentList(context, categoria)).toList(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDocumentDialog(context);
        },
        child: Icon(Icons.add),
        tooltip: 'Adicionar Documento',
      ),
    );
  }

  Widget _buildDocumentList(BuildContext context, String categoria) {
    final filteredDocuments = documentos.where((doc) => doc['type'] == categoria).toList();

    return ListView.builder(
      itemCount: filteredDocuments.length,
      itemBuilder: (context, index) {
        final document = filteredDocuments[index];
        return Card(
          margin: EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(document['title']!),
            subtitle: Text('Tipo: ${document['type']}'),
            trailing: IconButton(
              icon: Icon(Icons.download),
              onPressed: () {
                _downloadDocument(document['url']!);
              },
            ),
          ),
        );
      },
    );
  }

  void _downloadDocument(String url) {
    print('Baixando: $url');
  }

  void _showAddDocumentDialog(BuildContext context) {
    final titleController = TextEditingController();
    String? selectedCategory;
    String? filePath;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Adicionar Documento'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Nome do Documento'),
                ),
                DropdownButton<String>(
                  hint: Text('Selecione a Categoria'),
                  value: selectedCategory,
                  onChanged: (newValue) {
                    selectedCategory = newValue;
                  },
                  items: categorias.map((categoria) {
                    return DropdownMenuItem(
                      child: Text(categoria),
                      value: categoria,
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  onPressed: () async {
                    // Usando o file_picker para selecionar um arquivo
                    final result = await FilePicker.platform.pickFiles();
                    if (result != null && result.files.isNotEmpty) {
                      filePath = result.files.single.path;
                    }
                  },
                  child: Text('Selecionar Arquivo'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final title = titleController.text;
                if (title.isNotEmpty && selectedCategory != null && filePath != null) {
                  documentos.add({
                    'title': title,
                    'type': selectedCategory!,
                    'url': filePath!,
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
}
