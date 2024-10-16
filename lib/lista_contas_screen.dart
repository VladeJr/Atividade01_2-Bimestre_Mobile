import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListaContasScreen extends StatefulWidget {
  @override
  _ListaContasScreenState createState() => _ListaContasScreenState();
}

class _ListaContasScreenState extends State<ListaContasScreen> {
  List<dynamic> contas = [];

  Future<void> _carregarContas() async {
    final response = await http.get(Uri.parse('http://localhost:3000/contas'));
    if (response.statusCode == 200) {
      setState(() {
        contas = jsonDecode(response.body);
      });
    }
  }

  Future<void> _excluirConta(int id) async {
    final response =
        await http.delete(Uri.parse('http://localhost:3000/contas/$id'));
    if (response.statusCode == 200) {
      _carregarContas();
    }
  }

  @override
  void initState() {
    super.initState();
    _carregarContas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lista de Contas')),
      body: ListView.builder(
        itemCount: contas.length,
        itemBuilder: (context, index) {
          final conta = contas[index];
          return ListTile(
            title: Text(conta['nome']),
            subtitle: Text('Saldo: R\$${conta['saldo']}'),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _excluirConta(conta['id']),
            ),
          );
        },
      ),
    );
  }
}
