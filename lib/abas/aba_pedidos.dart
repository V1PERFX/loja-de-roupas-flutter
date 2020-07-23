import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/modelos/modelo_usuario.dart';
import 'package:lojavirtual/telas/tela_login.dart';
import 'package:lojavirtual/tiles/pedidos_tile.dart';

class AbaPedidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (ModeloUsuario.of(context).estaLogado()) {
      
      String uid = ModeloUsuario.of(context).firebaseUsuario.uid;

      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance.collection("usuarios").document(uid)
        .collection("pedidos").getDocuments(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
              children: snapshot.data.documents.map((doc) => PedidosTile(doc.documentID)).toList()
              .reversed.toList(),
            );
          }
        },
      );
    } else {
      return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.view_list,
              size: 80,
              color: Colors.amber[900],
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              "Faça o login para acompanhar!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(
              child: Text(
                "Entrar",
                style: TextStyle(fontSize: 18),
              ),
              textColor: Colors.white,
              color: Colors.blue[800],
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TelaLogin()));
              },
            ),
          ],
        ),
      );
    }
  }
}
