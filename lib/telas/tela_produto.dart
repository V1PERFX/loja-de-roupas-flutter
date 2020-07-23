import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/dados/carrinho_produto.dart';
import 'package:lojavirtual/dados/dados_produtos.dart';
import 'package:lojavirtual/modelos/modelo_carrinho.dart';
import 'package:lojavirtual/modelos/modelo_usuario.dart';
import 'package:lojavirtual/telas/tela_carrinho.dart';
import 'package:lojavirtual/telas/tela_login.dart';

class TelaProduto extends StatefulWidget {
  
  final DadosProdutos dados;

  TelaProduto(this.dados);
  
  @override
  _TelaProdutoState createState() => _TelaProdutoState(dados);
}

class _TelaProdutoState extends State<TelaProduto> {
  
  final DadosProdutos dados;

  String tamanho;
  
  _TelaProdutoState(this.dados);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(dados.titulo),
        centerTitle: true,
        backgroundColor: Colors.amber[800],
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: dados.imagens.map((url){
                return NetworkImage(url);
              }).toList(),
              dotSize: 4,
              dotSpacing: 15,
              dotBgColor: Colors.transparent,
              dotIncreasedColor: Colors.blue[800],
              dotColor: Colors.amber[900],
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  dados.titulo,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$ ${dados.preco.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 16,),
                Text(
                  "Tamanhos",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.5,
                    ),
                    children: dados.tamanhos.map(
                      (tam){
                        return GestureDetector(
                          onTap: (){
                            setState(() {
                              tamanho = tam;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              border: Border.all(
                                color: tam == tamanho ? Colors.amber[900] : Colors.grey[500],
                                width: 3,
                              ),
                            ),
                            width: 50,
                            alignment: Alignment.center,
                            child: Text(tam),
                          ),
                        );
                      }
                    ).toList(),
                  ),
                ),
                SizedBox(height: 16,),
                SizedBox(
                  height: 44,
                  child: RaisedButton(
                    onPressed: tamanho != null ?
                    (){
                      if(ModeloUsuario.of(context).estaLogado()) {
                        CarrinhoProduto carrinhoProduto = CarrinhoProduto();
                        carrinhoProduto.tamanho = tamanho;
                        carrinhoProduto.quantidade = 1;
                        carrinhoProduto.produtoId = dados.id;
                        carrinhoProduto.categoria = dados.categoria;
                        carrinhoProduto.dadosProduto = dados;

                        ModeloCarrinho.of(context).addItensCarrinho(carrinhoProduto);

                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>TelaCarrinho())
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>TelaLogin())
                        );
                      }
                    } : null,
                    child: Text(ModeloUsuario.of(context).estaLogado() ? "Adicionar ao Carrinho"
                      : "Entre Para Comprar",
                      style: TextStyle(fontSize: 18),
                    ),
                    color: Colors.blue[800],
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(height: 16,),
                Text(
                  "Descrição",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  dados.descricao,
                  style: TextStyle(
                    fontSize: 16
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}