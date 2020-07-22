import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojavirtual/dados/carrinho_produto.dart';
import 'package:lojavirtual/modelos/modelo_usuario.dart';
import 'package:scoped_model/scoped_model.dart';

class ModeloCarrinho extends Model {

  ModeloUsuario usuario;

  List<CarrinhoProduto> produtos = [];

  String codigoCupom;
  int descontoPorcentagem = 0;

  bool estaCarregando = false;

  ModeloCarrinho(this.usuario){
    if(usuario.estaLogado()) {
      _carregarItensCarrinho();
    }
  }

  static ModeloCarrinho of(BuildContext context) => 
  ScopedModel.of<ModeloCarrinho>(context);

  void addItensCarrinho(CarrinhoProduto carrinhoProduto) {
    produtos.add(carrinhoProduto);

    Firestore.instance.collection("usuarios").document(usuario.firebaseUsuario.uid)
    .collection("carrinho").add(carrinhoProduto.paraMap()).then((doc){
      carrinhoProduto.carrinhoId = doc.documentID;
    });

    notifyListeners();
  }

  void removeItensCarrinho(CarrinhoProduto carrinhoProduto) {
    Firestore.instance.collection("usuarios").document(usuario.firebaseUsuario.uid)
    .collection("carrinho").document(carrinhoProduto.carrinhoId).delete();

    produtos.remove(carrinhoProduto);

    notifyListeners();
  }

  void decProduto(CarrinhoProduto carrinhoProduto) {
    carrinhoProduto.quantidade--;

    Firestore.instance.collection("usuarios").document(usuario.firebaseUsuario.uid)
    .collection("carrinho").document(carrinhoProduto.carrinhoId).updateData(carrinhoProduto.paraMap());

    notifyListeners();
  }

  void incProduto(CarrinhoProduto carrinhoProduto) {
    carrinhoProduto.quantidade++;

    Firestore.instance.collection("usuarios").document(usuario.firebaseUsuario.uid)
    .collection("carrinho").document(carrinhoProduto.carrinhoId).updateData(carrinhoProduto.paraMap());

    notifyListeners();
  }

  void aplicaCupom(String codigoCupom, int descontoPorcentagem) {
    this.codigoCupom = codigoCupom;
    this.descontoPorcentagem = descontoPorcentagem;
  }

  void atualizaPreco() {
    notifyListeners();
  }

  double getPrecoProduto() {
    double preco = 0.0;
    for(CarrinhoProduto c in produtos){
      if(c.dadosProduto != null){
        preco += c.quantidade * c.dadosProduto.preco;
      }
    }
    return preco;
  }

  double getDesconto() {
    return getPrecoProduto() * descontoPorcentagem / 100;
  }

  // ignore: todo
  // TODO: código abaixo pode remover.
  double getPrecoEnvio() {
    return 9.99;
  }

  Future<String> finalizarPedido() async {
    if(produtos.length == 0) return null;

    estaCarregando = true;
    notifyListeners();

    double precoProdutos = getPrecoProduto();
    double desconto = getDesconto();
    double precoEnvio = getPrecoEnvio();

    DocumentReference refPedido = await Firestore.instance.collection("pedidos").add(
      {
        "clienteId": usuario.firebaseUsuario.uid,
        "produtos": produtos.map((carrinhoProduto)=>carrinhoProduto.paraMap()).toList(),
        "precoEnvio": precoEnvio,
        "precoProdutos": precoProdutos,
        "desconto": desconto,
        "precoTotal": precoProdutos - desconto + precoEnvio,
        "status": 1
      }
    );

    await Firestore.instance.collection("usuarios").document(usuario.firebaseUsuario.uid)
    .collection("pedidos").document(refPedido.documentID).setData(
      {
        "pedidoId": refPedido.documentID
      }
    );

    QuerySnapshot query = await Firestore.instance.collection("usuarios").document(usuario.firebaseUsuario.uid)
    .collection("carrinho").getDocuments();

    for(DocumentSnapshot doc in query.documents){
      doc.reference.delete();
    }

    produtos.clear();
    codigoCupom = null;
    descontoPorcentagem = 0;

    estaCarregando = false;
    notifyListeners();

    return refPedido.documentID;
  }

  void _carregarItensCarrinho() async {
    QuerySnapshot query = await Firestore.instance.collection("usuarios").document(usuario.firebaseUsuario.uid)
    .collection("carrinho").getDocuments();

    produtos = query.documents.map((doc) => CarrinhoProduto.fromDocument(doc)).toList();

    notifyListeners();
  }
}