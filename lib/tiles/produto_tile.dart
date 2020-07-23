import 'package:flutter/material.dart';
import 'package:lojavirtual/dados/dados_produtos.dart';
import 'package:lojavirtual/telas/tela_produto.dart';

class ProdutoTile extends StatelessWidget {
  
  final String tipo;
  final DadosProdutos dados;

  ProdutoTile(this.tipo, this.dados);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>TelaProduto(dados))
        );
      },
      child: Card(
        child: tipo == "grid" ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 0.8,
                child: Image.network(
                  dados.imagens[0],
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(dados.titulo,
                        style: TextStyle(
                          //fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "R\$ ${dados.preco.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.amber[900],
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
          : Row(
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Image.network(
                  dados.imagens[0],
                  fit: BoxFit.cover,
                  height: 250,
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(dados.titulo,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(dados.descricao,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "R\$ ${dados.preco.toStringAsFixed(2)}",
                        style: TextStyle(
                          color: Colors.amber[900],
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}