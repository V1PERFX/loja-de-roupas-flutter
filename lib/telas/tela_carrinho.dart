import 'package:flutter/material.dart';
import 'package:lojavirtual/modelos/modelo_carrinho.dart';
import 'package:lojavirtual/modelos/modelo_usuario.dart';
import 'package:lojavirtual/telas/tela_login.dart';
import 'package:lojavirtual/telas/tela_pedido.dart';
import 'package:lojavirtual/tiles/carrinho_tile.dart';
import 'package:lojavirtual/widgets/desconto_cartao.dart';
import 'package:lojavirtual/widgets/envio_cartao.dart';
import 'package:lojavirtual/widgets/preco_carrinho.dart';
import 'package:scoped_model/scoped_model.dart';

class TelaCarrinho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[800],
        title: Text("Meu Carrinho"),
        actions: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            child: ScopedModelDescendant<ModeloCarrinho>(
              builder: (context, child, model){
                int p = model.produtos.length;
                return Text(
                  "${p ?? 0} ${p == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 17),
                );
              },
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<ModeloCarrinho>(
        builder: (context, child, model){
          if(model.estaCarregando && ModeloUsuario.of(context).estaLogado()){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (!ModeloUsuario.of(context).estaLogado()){
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.remove_shopping_cart, 
                    size: 80, color: Colors.amber[900],),
                  SizedBox(height: 16,),
                  Text("Faça o login para adicionar produtos!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16,),
                  RaisedButton(
                    child: Text("Entrar", style: TextStyle(fontSize: 18),),
                    textColor: Colors.white,
                    color: Colors.blue[800],
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context)=>TelaLogin())
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (model.produtos == null || model.produtos.length == 0){
            return Center(
              child: Text("Nenhum produto no carrinho!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return ListView(
              children: <Widget>[
                Column(
                  children: model.produtos.map(
                    (produto){
                      return CarrinhoTile(produto);
                    }
                  ).toList(),
                ),
                DescontoCartao(),
                EnvioCartao(),
                PrecoCarrinho(() async {
                  String pedidoId = await model.finalizarPedido();
                  if(pedidoId != null){
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context)=>TelaPedido(pedidoId))
                    );
                  }
                }),
              ],
            );
          }
        }
      ),
    );
  }
}