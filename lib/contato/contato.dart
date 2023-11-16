import 'dart:convert';

class Contato{
  
  dynamic id;
  String? nome;
  dynamic idade;

  Contato({this.id, this.nome, this.idade});

Contato fromSqlite(Map<String, dynamic> row) {
    return Contato(
      id: row['_id'] ?? '',
      nome: row['nome'],
      idade: row['idade'],
      //atributo: row['atributo'] ?? '', 
    );
  }

  Map<String, dynamic> toSqlite() {
    Map<String, dynamic> row;
    return row = {
      '_id': id,
      'nome': nome,
      'idade': idade
    };
  }
  
}