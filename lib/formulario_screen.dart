import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FormularioScreen extends StatefulWidget {
  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _saldoController = TextEditingController();

  Future<void> _adicionarConta() async {
    final nome = _nomeController.text;
    final saldo = double.tryParse(_saldoController.text) ?? 0;

    final response = await http.post(
      Uri.parse('http://localhost:3000/contas'),
      headers: {'Content-Type': 'application/json'},
      body: '{"nome": "$nome", "saldo": $saldo}',
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Conta adicionada com sucesso!')),
      );
      _nomeController.clear();
      _saldoController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao adicionar conta.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Conta')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _saldoController,
              decoration: InputDecoration(labelText: 'Saldo'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _adicionarConta,
              child: Text('Adicionar'),
            ),
          ],
        ),
      ),
    );
  }
}
