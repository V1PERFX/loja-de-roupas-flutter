import 'package:flutter/material.dart';
import 'package:lojavirtual/telas/tela_carrinho.dart';

class BotaoCarrinho extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart, color: Colors.white,),
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>TelaCarrinho())
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}