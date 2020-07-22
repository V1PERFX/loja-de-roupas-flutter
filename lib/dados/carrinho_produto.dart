import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojavirtual/dados/dados_produtos.dart';

class CarrinhoProduto {
  String carrinhoId;
  String categoria;
  String produtoId;
  int quantidade;
  String tamanho;

  DadosProdutos dadosProduto;

  CarrinhoProduto();

  CarrinhoProduto.fromDocument(DocumentSnapshot documento) {
    carrinhoId = documento.documentID;
    categoria = documento.data["categoria"];
    produtoId = documento.data["pid"];
    quantidade = documento.data["quantidade"];
    tamanho = documento.data["tamanho"];
  }

  Map<String, dynamic> paraMap() {
    return {
      "categoria": categoria,
      "pid": produtoId,
      "quantidade": quantidade,
      "tamanho": tamanho,
      "produto": dadosProduto.mapaResumido()
    };
  }
}