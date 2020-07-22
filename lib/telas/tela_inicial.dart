import 'package:flutter/material.dart';
import 'package:lojavirtual/abas/aba_inicial.dart';
import 'package:lojavirtual/abas/aba_lojas.dart';
import 'package:lojavirtual/abas/aba_pedidos.dart';
import 'package:lojavirtual/abas/aba_produtos.dart';
import 'package:lojavirtual/widgets/botao_carrinho.dart';
import 'package:lojavirtual/widgets/gaveta_personalizada.dart';

class TelaInicial extends StatelessWidget {

  final _controladorPagina = PageController();

  @override
  Widget build(BuildContext context) {

    return PageView(
      controller: _controladorPagina,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          body: AbaInicial(),
          drawer: GavetaPersonalizada(_controladorPagina),
          floatingActionButton: BotaoCarrinho(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
            backgroundColor: Color.fromARGB(255, 238, 174, 202),
          ),
          drawer: GavetaPersonalizada(_controladorPagina),
          body: AbaProdutos(),
          floatingActionButton: BotaoCarrinho(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Lojas"),
            centerTitle: true,
          ),
          body: AbaLojas(),
          drawer: GavetaPersonalizada(_controladorPagina),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: AbaPedidos(),
          drawer: GavetaPersonalizada(_controladorPagina),
        ),
      ],
    );
  }
}