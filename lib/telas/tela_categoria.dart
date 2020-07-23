import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/dados/dados_produtos.dart';
import 'package:lojavirtual/tiles/produto_tile.dart';

class TelaCategoria extends StatelessWidget {
  
  final DocumentSnapshot snapshot;

  TelaCategoria(this.snapshot);
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[800],
          title: Text(snapshot.data["titulo"]),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on),),
              Tab(icon: Icon(Icons.list),),
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection("produtos").document(snapshot.documentID)
          .collection("itens").getDocuments(),
          builder: (context, snapshot){
            if(!snapshot.hasData)
              return Center(child: CircularProgressIndicator(),);
            else
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  GridView.builder(
                    padding: EdgeInsets.all(4),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){
                      DadosProdutos data = DadosProdutos.doDocumento(snapshot.data.documents[index]);
                      data.categoria = this.snapshot.documentID;
                      return ProdutoTile("grid", data);
                    }
                  ),
                  ListView.builder(
                    padding: EdgeInsets.all(4),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){
                      DadosProdutos data = DadosProdutos.doDocumento(snapshot.data.documents[index]);
                      data.categoria = this.snapshot.documentID;
                      return ProdutoTile("lista", data);
                    }
                  ),
                ],
              );
          },
        ),
      ),
    );
  }
}