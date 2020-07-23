import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/dados/carrinho_produto.dart';
import 'package:lojavirtual/dados/dados_produtos.dart';
import 'package:lojavirtual/modelos/modelo_carrinho.dart';

class CarrinhoTile extends StatelessWidget {

  final CarrinhoProduto carrinhoProduto;

  CarrinhoTile(this.carrinhoProduto);

  @override
  Widget build(BuildContext context) {

    Widget _buildConteudo(){
      ModeloCarrinho.of(context).atualizaPreco();
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(8),
            width: 120,
            child: Image.network(
              carrinhoProduto.dadosProduto.imagens[0],
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(carrinhoProduto.dadosProduto.titulo,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                  Text(
                    "Tamanho: ${carrinhoProduto.tamanho}",
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "R\$ ${carrinhoProduto.dadosProduto.preco.toStringAsFixed(2)}",
                    style: TextStyle(
                      color: Colors.blue[800],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.remove),
                        color: Colors.amber[900],
                        onPressed: carrinhoProduto.quantidade > 1 ?
                        (){
                          ModeloCarrinho.of(context).decProduto(carrinhoProduto);
                        } : null,
                      ),
                      Text(carrinhoProduto.quantidade.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        color: Colors.amber[900],
                        onPressed: (){
                          ModeloCarrinho.of(context).incProduto(carrinhoProduto);
                        },
                      ),
                      FlatButton(
                        child: Text("Remover"),
                        textColor: Colors.grey[500],
                        onPressed: (){
                          ModeloCarrinho.of(context).removeItensCarrinho(carrinhoProduto);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: carrinhoProduto.dadosProduto == null ?
        FutureBuilder<DocumentSnapshot>(
          future: Firestore.instance.collection("produtos").document(carrinhoProduto.categoria)
          .collection("itens").document(carrinhoProduto.produtoId).get(),
          builder: (context, snapshot){
            if(snapshot.hasData){
              carrinhoProduto.dadosProduto = DadosProdutos.doDocumento(snapshot.data);
              return _buildConteudo();
            } else {
              return Container(
                height: 70,
                child: CircularProgressIndicator(),
                alignment: Alignment.center,
              );
            }
          },
        ) :
          _buildConteudo()
    );
  }
}