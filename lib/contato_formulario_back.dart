
import 'package:flutter_application_1/contato/contato.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'contato_formulario_back.g.dart';

class ContatoFormularioBack = _ContatoFormularioBack with _$ContatoFormularioBack;

abstract class _ContatoFormularioBack with Store{

  late Contato contato;

  // diferenciar novo com alteração 
  _ContatoFormularioBack(BuildContext context){
    var parameter = ModalRoute.of(context)?.settings.arguments;
    if ((parameter == null)) {
      contato = Contato();
    } else {
      contato = parameter as Contato;
    }
  }

}  

