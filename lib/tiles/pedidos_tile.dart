import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PedidosTile extends StatelessWidget {

  final String pedidoId;

  PedidosTile(this.pedidoId);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(
          stream: Firestore.instance.collection("pedidos").document(pedidoId).snapshots(),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {

              int status = snapshot.data["status"];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Código do pedido: ${snapshot.data.documentID}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    _buildTextoProdutos(snapshot.data)
                  ),
                  SizedBox(height: 4,),
                  Text(
                    "Status do pedido:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      _buildCirculo("1", "Preparação", status, 1),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey[500],
                      ),
                      _buildCirculo("2", "Transporte", status, 2),
                      Container(
                        height: 1,
                        width: 40,
                        color: Colors.grey[500],
                      ),
                      _buildCirculo("3", "Entrega", status, 3),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String _buildTextoProdutos(DocumentSnapshot snapshot){
    String texto = "Descrição:\n";
    for(LinkedHashMap p in snapshot.data["produtos"]){
      texto += "${p["quantidade"]} x ${p["produto"]["titulo"]} (R\$ ${p["produto"]["preco"].toStringAsFixed(2)})\n";
    }
    texto += "Total: R\$ ${snapshot.data["precoTotal"].toStringAsFixed(2)}";
    return texto;
  }

  Widget _buildCirculo(String titulo, String subtitulo, int status, int thisStatus) {
    Color backCor;
    Widget filho;

    if(status < thisStatus){
      backCor = Colors.grey[500];
      filho = Text(titulo, style: TextStyle(color: Colors.white));
    } else if(status == thisStatus){
      backCor = Colors.blue;
      filho = Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Text(titulo, style: TextStyle(color: Colors.white),),
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
        ],
      );
    } else {
      backCor = Colors.green;
      filho = Icon(Icons.check, color: Colors.white,);
    }

    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 20,
          backgroundColor: backCor,
          child: filho,
        ),
        Text(subtitulo),
      ],
    );
  }
}