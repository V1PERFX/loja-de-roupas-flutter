import 'package:flutter/material.dart';
import 'package:lojavirtual/modelos/modelo_usuario.dart';
import 'package:lojavirtual/telas/tela_inscricao.dart';
import 'package:scoped_model/scoped_model.dart';

class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final _emailControle = TextEditingController();
  final _senhaControle = TextEditingController();

  final _formChave = GlobalKey<FormState>();
  final _scaffoldChave = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldChave,
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              "CRIAR CONTA",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => TelaInscricao()),
              );
            },
          ),
        ],
      ),
      body: ScopedModelDescendant<ModeloUsuario>(
        builder: (context, child, model) {
          if (model.estaCarregando) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Form(
              key: _formChave,
              child: ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  TextFormField(
                    controller: _emailControle,
                    decoration: InputDecoration(
                      hintText: "E-mail",
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (email) {
                      if (email.isEmpty || !email.contains("@")) {
                        return "E-mail Inválido";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    controller: _senhaControle,
                    decoration: InputDecoration(
                      hintText: "Senha",
                    ),
                    obscureText: true,
                    validator: (senha) {
                      if (senha.isEmpty || senha.length < 6) {
                        return "Senha inválida";
                      } else {
                        return null;
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(
                      onPressed: () {
                        if (_emailControle.text.isEmpty) {
                          _scaffoldChave.currentState.showSnackBar(SnackBar(
                            content: Text("Insira seu e-mail para recuperção!"),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          model.recuperarSenha(_emailControle.text);
                          _scaffoldChave.currentState.showSnackBar(SnackBar(
                            content: Text("Confira seu e-mail!"),
                            backgroundColor: Theme.of(context).primaryColor,
                            duration: Duration(seconds: 2),
                          ));
                        }
                      },
                      child: Text(
                        "Esqueceu a senha?",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        if (_formChave.currentState.validate()) {}
                        model.entrar(
                            email: _emailControle.text,
                            senha: _senhaControle.text,
                            noSucesso: _noSucesso,
                            naFalha: _naFalha);
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
    Navigator.of(context).pop();
  }

  void _naFalha() {
    _scaffoldChave.currentState.showSnackBar(SnackBar(
      content: Text("Falha ao entrar!"),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}
