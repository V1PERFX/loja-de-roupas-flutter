import 'package:flutter/material.dart';

class TelaPedido extends StatelessWidget {

  final String pedidoId;

  TelaPedido(this.pedidoId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Finalização Pedido"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check,
              color: Theme.of(context).primaryColor,
              size: 80,
            ),
            Text("Pedido realizado com sucesso!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text("Código do pedido: $pedidoId",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}