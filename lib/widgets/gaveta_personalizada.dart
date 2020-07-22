import 'package:flutter/material.dart';
import 'package:lojavirtual/modelos/modelo_usuario.dart';
import 'package:lojavirtual/telas/tela_login.dart';
import 'package:lojavirtual/tiles/gaveta_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class GavetaPersonalizada extends StatelessWidget {

  final PageController controladorPagina;

  GavetaPersonalizada(this.controladorPagina);

  @override
  Widget build(BuildContext context) {

    Widget _criarGavetaCorpo() => Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 203, 236, 241),
            Color.fromARGB(255, 255, 255, 255),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _criarGavetaCorpo(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8,
                      left: 0,
                      child: Text("Bella's\nFashion",
                        style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: ScopedModelDescendant<ModeloUsuario>(
                        builder: (context, child, model) {
                          return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Olá, ${!model.estaLogado() ? "" : model.usuarioData["nome"]}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GestureDetector(
                            child: Text(
                              !model.estaLogado() ?
                              "Entre ou cadastre-se >"
                              : "Sair",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onTap: (){
                              if(!model.estaLogado()) {
                                Navigator.of(context).push(
                                MaterialPageRoute(builder: (context)=>TelaLogin())
                              );
                              } else {
                                model.sair();
                              }
                              
                            },
                          ),
                        ],
                      );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              GavetaTile(Icons.home, "Início", controladorPagina, 0),
              GavetaTile(Icons.list, "Produtos", controladorPagina, 1),
              GavetaTile(Icons.location_on, "Lojas", controladorPagina, 2),
              GavetaTile(Icons.playlist_add_check, "Meus Pedidos", controladorPagina, 3),
            ],
          ),
        ],
      ),
    );
  }
}