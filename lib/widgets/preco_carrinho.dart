import 'package:flutter/material.dart';
import 'package:lojavirtual/modelos/modelo_carrinho.dart';
import 'package:scoped_model/scoped_model.dart';

class PrecoCarrinho extends StatelessWidget {

  final VoidCallback comprar;

  PrecoCarrinho(this.comprar);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: EdgeInsets.all(16),
        child: ScopedModelDescendant<ModeloCarrinho>(
          builder: (context, child, model){

            double preco = model.getPrecoProduto();
            double desconto = model.getDesconto();
            double envio = model.getPrecoEnvio();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "Resumo do pedido",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Subtotal"),
                    Text("R\$ ${preco.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Desconto"),
                    Text("R\$ ${desconto.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Entrega"),
                    Text("R\$ ${envio.toStringAsFixed(2)}"),
                  ],
                ),
                Divider(),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Total",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text("R\$ ${(preco + envio - desconto).toStringAsFixed(2)}",
                      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(height: 12,),
                RaisedButton(
                  child: Text("Finalizar Pedido"),
                  textColor: Colors.white,
                  color: Theme.of(context).primaryColor,
                  onPressed: comprar,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}