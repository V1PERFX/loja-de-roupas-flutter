import 'package:flutter/material.dart';
import 'package:lojavirtual/modelos/modelo_usuario.dart';
import 'package:scoped_model/scoped_model.dart';

class TelaInscricao extends StatefulWidget {
  @override
  _TelaInscricaoState createState() => _TelaInscricaoState();
}

class _TelaInscricaoState extends State<TelaInscricao> {
  
  final _nomeControle = TextEditingController();
  final _emailControle = TextEditingController();
  final _senhaControle = TextEditingController();
  final _enderecoControle = TextEditingController();

  final _formChave = GlobalKey<FormState>();
  final _scaffoldChave = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldChave,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Criar Conta"),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<ModeloUsuario>(
        builder: (context, child, model) {
          if(model.estaCarregando) {
            return Center(child: CircularProgressIndicator(),);
          } else {
         return Form(
        key: _formChave,
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              controller: _nomeControle,
              decoration: InputDecoration(
                hintText: "Nome Completo",
              ),
              validator: (nome){
                if(nome.isEmpty) {
                  return "Nome Inválido";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 16,),
            TextFormField(
              controller: _emailControle,
              decoration: InputDecoration(
                hintText: "E-mail",
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (email){
                if(email.isEmpty || !email.contains("@")) {
                  return "E-mail Inválido";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 16,),
            TextFormField(
              controller: _senhaControle,
              decoration: InputDecoration(
                hintText: "Senha",
              ),
              obscureText: true,
              validator: (senha){
                if(senha.isEmpty || senha.length < 6) {
                  return "Senha inválida";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 16,),
            TextFormField(
              controller: _enderecoControle,
              decoration: InputDecoration(
                hintText: "Endereço",
              ),
              validator: (endereco){
                if(endereco.isEmpty) {
                  return "Endereço inválido";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 16,),
            SizedBox(
              height: 44,
              child: RaisedButton(
                child: Text("Criar Conta e Entrar",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: (){
                if(_formChave.currentState.validate()) {

                  Map<String, dynamic> usuarioData = {
                    "nome": _nomeControle.text,
                    "email": _emailControle.text,
                    "endereco": _enderecoControle.text
                  };

                  model.inscrever(
                    usuarioData: usuarioData, 
                    senha: _senhaControle.text, 
                    noSucesso: _noSucesso, 
                    naFalha: _naFalha
                  );
                }
              },
              ),
            ),
          ],
        ),
      );
      }
        },
      ),
    );
  }

  void _noSucesso() {
    _scaffoldChave.currentState.showSnackBar(
      SnackBar(
        content: Text("Usuário criado com sucesso!"),
        backgroundColor: Theme.of(context).primaryColor,
        duration: Duration(seconds: 2),
      )
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void _naFalha() {
    _scaffoldChave.currentState.showSnackBar(
      SnackBar(
        content: Text("Falha ao criar usuário!"),
        backgroundColor: Colors.redAccent,
        duration: Duration(seconds: 2),
      )
    );
  }
}