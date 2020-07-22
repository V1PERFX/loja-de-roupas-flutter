import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/telas/tela_categoria.dart';

class CategoriaTile extends StatelessWidget {

  final DocumentSnapshot dSnapshot;

  CategoriaTile(this.dSnapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(dSnapshot.data["icone"]),
      ),
      title: Text(dSnapshot.data["titulo"]),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>TelaCategoria(dSnapshot))
        );
      },
    );
  }
}