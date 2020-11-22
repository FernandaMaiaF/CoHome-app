import 'package:flutter/foundation.dart';

class FamiliaMembros with ChangeNotifier {
  String id;
  final String nome;

  FamiliaMembros({
    this.id,
    @required this.nome,
  });
}

final CONVITES = [
  FamiliaMembros(
    id: 'dftyui',
    nome: 'Fernanda Maia',
  ),
  FamiliaMembros(
    id: 'ftyuio,mn',
    nome: 'Alessandra Maia',
  ),
];

class ListaMembros with ChangeNotifier {
  List<FamiliaMembros> _items = CONVITES;
  List<FamiliaMembros> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }
}
