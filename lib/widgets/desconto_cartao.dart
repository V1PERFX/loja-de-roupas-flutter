import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/modelos/modelo_carrinho.dart';

class DescontoCartao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          "Cupom de Desconto",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        leading: Icon(Icons.card_membership),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Digite seu cupom",
              ),
              initialValue: ModeloCarrinho.of(context).codigoCupom ?? "",
              onFieldSubmitted: (texto){
                Firestore.instance.collection("cupons").document(texto).get().then(
                  (docSnap) {
                    if(docSnap.data != null){
                      ModeloCarrinho.of(context).aplicaCupom(texto, docSnap.data["porcentagem"]);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Desconto de ${docSnap.data["porcentagem"]}% aplicado!"),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      );
                    } else {
                      ModeloCarrinho.of(context).aplicaCupom(null, 0);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Cupom não existente!"),
                          backgroundColor: Colors.redAccent,
                        ),
                      );
                    }
                  });
              },
            ),
          ),
        ],
      ),
    );
  }
}