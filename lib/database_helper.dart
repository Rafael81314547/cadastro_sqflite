import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{
  static final _databaseName = "ExemploDB.db";
  static final _databaseVersion = 1;
  static final table = 'contato';
  static final columnId = '_id';
  static final columnNome = 'nome';
  static final columnIdade = 'idade';

  // torna esta classe singleton
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = 
        DatabaseHelper._privateConstructor();

  // tem somente uma referencia ao banco de dados
  static Database? _database;

  Future<Database> get database async =>
        _database ??= await _initDatabase();

  // abre o banco de dados e o cria se ele não existir
  _initDatabase() async {
    Directory documentsDirectory = await
        getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
         version: _databaseVersion,
         onCreate: _onCreate);
  }
    // codigo sql para criar o banco de dados e a tabela
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            $columnNome TEXT NOT NULL,
            $columnIdade INTEGER NOT NULL
          )
          ''');
  }

  // METODOS HELPER
  // -----------------------------------------
  // Insere uma linha no banco de dados onde cada chave 
  // no Map e um nome de coluna e o valor e o valor da coluna.
  //o valor  de retorno e o id da linha inserida;
  //
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }  
  // todas as linhas são retornadas como um lista de mapas, onde cada
  // mapa é uma linha de valores-chave de colunas.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
    
  }

  // todos os metodos: inserir, consultar atualizar e excluir
  // tambem podem ser feitos usados comando sql brutos
  // esse metodos usa uma consulta bruta para fornecer a contagem de linhas
  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }
// Assumimos aqui que a coluna id no mapa esta definida. os outros 
// valores das colunas serão usados para atualizar a linha
Future<int> update(Map<String, dynamic> row) async {
  Database db = await instance.database;
  int id = row[columnId];
  return await db.update(table, row, where: '$columnId = ?',
      whereArgs: [id]);
}
// exclui a linha especificada pelo id. o numero de linhas afetadas e 
// retornada. isso deve ser igual a 1, contanto que a linha exista
Future<int> delete(int id) async {
  Database db = await instance.database;
  return
    await db.delete(table, where: '$columnId = ?',
           whereArgs: [id]);
}


}