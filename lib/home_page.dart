import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // cria uma instancia do flutterSecureStorage
  final _storage = FlutterSecureStorage();
  String _username = '';
  String _password = '';

  @override
  void initState() {
    super.initState();
    _loadCredentials();
  }

  // Ler Credenciais
  Future<void> _loadCredentials() async {
    final username = await _storage.read(key: 'username');
    final password = await _storage.read(key: 'password');
    setState(() {
      _username = username ?? '';
      _password = password ?? '';
    });
  }

  //Salva Credenciais
  Future<void> _saveCredentials() async {
    await _storage.write(key: 'username', value: _username);
    await _storage.write(key: 'password', value: _password);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Credenciais salvas com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Armazenamento Seguro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'Usuário'),
              onChanged: (value) => _username = value,
            ),
            SizedBox(height: 8.0),
            TextField(
              decoration: InputDecoration(hintText: 'Senha'),
              obscureText: true,
              onChanged: (value) => _password = value,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveCredentials,
              child: Text('Salvar Credenciais'),
            ),
            SizedBox(height: 16.0),
            Text('Usuário: $_username'),
            Text('Senha: $_password'),
          ],
        ),
      ),
    );
  }
}
