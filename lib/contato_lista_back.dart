import 'package:flutter_application_1/contato/contato.dart';
import 'package:flutter_application_1/contato/database_helper.dart';
import 'package:flutter_application_1/my_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';


part'contato_lista_back.g.dart';

class ContatoListBack = _ContatoListBack with _$ContatoListBack;

abstract class _ContatoListBack with Store{
  final dbHelperSqlite = DatabaseHelper.instance;

  //lista de contatos 
  @observable
  Future<List<Contato>>? list;

  //método para atualizar a lista de contatos
  @action
  refreshList([dynamic value]) async{   
    final todasLinhas = await dbHelperSqlite.queryAllRows();
    print('Consulta todas as linhas _refreshList():');
    todasLinhas.forEach((row) => print(row));
    
    List<Contato> list = List.generate( 
      todasLinhas.length, (i){
        var linha = todasLinhas[i];
        print(i);
        return Contato(
          id : linha['_id'],
          nome: linha['nome'],
          idade: linha['idade']
        );
      }
    );
    
  }

  _ContatoListBack(){
    print('passou no construtor e chamou o refresh');
    refreshList();
  }

  //método para chamar o form salvar/alterar
  goToForm(BuildContext context, [Contato? contato]){
    print('passou no goToForm');
    WidgetsBinding.instance.addPostFrameCallback((_){
      //Navigator.of(context).pushNamed(MyApp.CONTATO_FORM, arguments: contato).then(refreshList);
    Navigator.of(context).pushNamed(MyApp.CONTATO_FORM, arguments: contato);
    var teste;
    teste = contato?.nome;
    print('nome do usuario $teste');
    });
  }

  goToDetails(BuildContext context, Contato contato){
    //Navigator.of(context).pushNamed(MyApp.CONTATO_DETAILS, arguments: contato);
  }

  //excluir
  remove(dynamic id){
    dbHelperSqlite.delete(id); 
    refreshList();    
  }
}