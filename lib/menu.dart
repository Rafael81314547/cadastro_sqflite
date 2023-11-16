import 'package:flutter_application_1/contato_formulario.dart';
import 'package:flutter_application_1/contato_lista.dart';
import 'package:flutter/material.dart';
import 'dart:core';

class Menu extends StatefulWidget {
  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = ContatoList();
        break;
      case 1:
        page = ContatoFormulario();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
                            
                     
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.format_list_bulleted),
                      label: Text('Lista'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.contact_page_outlined),
                      label: Text('Cadastro de contato'),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onDestinationSelected: (value) {
                        setState(() {
                          selectedIndex = value;
                        });                                       
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}