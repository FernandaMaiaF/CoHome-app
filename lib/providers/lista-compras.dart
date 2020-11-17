import 'package:flutter/material.dart';
import 'dart:math';

//import 'package:http/http.dart' as http;
import './dados-compras.dart';

final COMPRAS = [
  Compra(
    id: 'p1',
    titulo: 'Banana',
    status: true,
    descricao: 'Comprar banana ouro',
  ),
  Compra(
    id: 'p2',
    titulo: 'fruta',
    status: false,
    descricao: 'Comprar tal fruta',
  ),
];

class Lista with ChangeNotifier {
  List<Compra> _items = COMPRAS;
  List<Compra> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  void addProduct(Compra newProduct) {
    // const url = '';
    // http.post(url,body: null);

    _items.add(Compra(
      id: Random().nextDouble().toString(),
      titulo: newProduct.titulo,
      status: newProduct.status,
      descricao: newProduct.descricao,
    ));
    notifyListeners();
  }

  //atualiza os produtos depois de salvar
  void updateProduct(Compra product) {
    if (product == null || product.id == null) {
      return;
    }

    final index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }
}
