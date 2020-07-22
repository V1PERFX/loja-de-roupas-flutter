import 'package:flutter/material.dart';
import 'package:lojavirtual/modelos/modelo_carrinho.dart';
import 'package:lojavirtual/modelos/modelo_usuario.dart';
import 'package:lojavirtual/telas/tela_inicial.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<ModeloUsuario>(
      model: ModeloUsuario(),
      child: ScopedModelDescendant<ModeloUsuario>(
        builder: (context, child, model) {
          return ScopedModel<ModeloCarrinho>(
        model: ModeloCarrinho(model),
        child: MaterialApp(
          title: "Bella Fashion",
          theme: ThemeData(
              primarySwatch: Colors.blue,
              primaryColor: Color.fromARGB(255, 4, 125, 141)),
          debugShowCheckedModeBanner: false,
          home: TelaInicial(),
        ),
      );
        }
      ),
    );
  }
}
