
import 'package:flutter/material.dart';
import 'package:flutter_application_1/database_helper.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQFlite Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Exemplo de CRUD básico'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Inserir dados',
                style: TextStyle(fontSize: 20),),
              onPressed: () {_inserir();},  
            ),
            ElevatedButton(
              child: Text('Consultar dados',
                style: TextStyle(fontSize: 20),),
              onPressed: () {_consultar();},
            ),
            ElevatedButton(
              child: Text('Atualizar dados',
                style: TextStyle(fontSize: 20),),
              onPressed: () {_atualizar();},
            ),
            ElevatedButton(
              child: Text('Deletar dados',
                style: TextStyle(fontSize: 20),),
              onPressed: () {_deletar();},
            ),
          ], 
        ),
      ),
    );
  }
  void _inserir() async{
    Map<String, dynamic> row = {
      DatabaseHelper.columnNome : 'João inserir',
      DatabaseHelper.columnIdade : 40
    };
    final id = await dbHelper.insert(row);
    print('linha inserida id: $id');

  }
  void _consultar() async {
    final todasLinhas = await dbHelper.queryAllRows();
    print('Consulta todas as linhas:');
    todasLinhas.forEach((row)=>print(row));
  }
  void _atualizar() async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnId  : 1,
      DatabaseHelper.columnNome : 'Maria atualizar',
      DatabaseHelper.columnIdade : 32
    };
    final linhasAfetadas = await dbHelper.update(row);
    print('atualizadas $linhasAfetadas linha(s)');

  }
  void _deletar() async {
    final id = await dbHelper.queryRowCount();
    final linhaDeletada = await dbHelper.delete(id!);
    print('Deleteda(s) $linhaDeletada linha(s): linha $id');
  }
}







