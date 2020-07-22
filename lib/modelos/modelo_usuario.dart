import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:scoped_model/scoped_model.dart';
import 'dart:async';
import 'package:flutter/material.dart';

class ModeloUsuario extends Model {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseUser firebaseUsuario;
  Map<String, dynamic> usuarioData = Map();

  bool estaCarregando = false;

  static ModeloUsuario of(BuildContext context) => 
  ScopedModel.of<ModeloUsuario>(context);

  @override
  void addListener(VoidCallback listener) {
    super.addListener(listener);

    _carregaUsuarioAtual();
  }

  void inscrever({@required Map<String, dynamic> usuarioData, @required String senha, 
    @required VoidCallback noSucesso, @required VoidCallback naFalha}) {
    estaCarregando = true;
    notifyListeners();

    _auth.createUserWithEmailAndPassword(
      email: usuarioData["email"], 
      password: senha
    ).then((usuario) async {
      firebaseUsuario = usuario.user;

      await _salvaUsuarioData(usuarioData);

      noSucesso();
      estaCarregando = false;
      notifyListeners();
    }).catchError((e) {
      naFalha();
      estaCarregando = false;
      notifyListeners();
    });
  }

  void entrar({@required String email, @required String senha,
   @required VoidCallback noSucesso, @required VoidCallback naFalha}) async {
    estaCarregando = true;
    notifyListeners();

    _auth.signInWithEmailAndPassword(email: email, password: senha).then(
      (usuario) async {
        firebaseUsuario = usuario.user;

        await _carregaUsuarioAtual();

        noSucesso();
        estaCarregando = false;
        notifyListeners();
      }).catchError((e){
        naFalha();
        estaCarregando = false;
        notifyListeners();
      });
  }

  void sair() async {
    await _auth.signOut();

    usuarioData = Map();
    firebaseUsuario = null;

    notifyListeners();
  }

  void recuperarSenha(String email) {
    _auth.sendPasswordResetEmail(email: email);
  }

  bool estaLogado() {
    return firebaseUsuario != null;
  }

  Future<Null> _salvaUsuarioData(Map<String, dynamic> usuarioData) async {
    this.usuarioData = usuarioData;
    await Firestore.instance.collection("usuarios").document(firebaseUsuario.uid).setData(usuarioData);
  }

  Future<Null> _carregaUsuarioAtual() async {
    if(firebaseUsuario == null) {
      firebaseUsuario = await _auth.currentUser();
    }

    if(firebaseUsuario != null) {
      if(usuarioData["nome"] == null){
        DocumentSnapshot docUsuario = 
          await Firestore.instance.collection("usuarios").document(firebaseUsuario.uid).get();
        usuarioData = docUsuario.data;
      }
    }
    notifyListeners();
  }
}