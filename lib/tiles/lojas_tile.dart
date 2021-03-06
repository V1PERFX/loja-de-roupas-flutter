import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LojasTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  LojasTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 100,
            child: Image.network(
              snapshot.data["imagem"],
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  snapshot.data["titulo"],
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Text(
                  snapshot.data["endereco"],
                  textAlign: TextAlign.start,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              FlatButton(
                child: Text("Ver no mapa"),
                textColor: Colors.blue[800],
                padding: EdgeInsets.zero,
                onPressed: (){
                  launch("https://www.google.com/maps/search/?api=1&query=${snapshot.data["latitude"]},"
                  "${snapshot.data["longetude"]}");
                },
              ),
              FlatButton(
                child: Text("Ligar"),
                textColor: Colors.blue[800],
                padding: EdgeInsets.zero,
                onPressed: (){
                  launch("tel:${snapshot.data["telefone"]}");
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}