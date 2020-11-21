import 'package:flutter/foundation.dart';

class Covite with ChangeNotifier {
  String id;
  final String nome;

  Covite({
    this.id,
    @required this.nome,
  });
}

final CONVITES = [
  Covite(
    id: 'dftyui',
    nome: 'Familia Maia',
  ),
  Covite(
    id: 'ftyuio,mn',
    nome: 'Familia Barros',
  ),
];

class ListaConvite with ChangeNotifier {
  List<Covite> _items = CONVITES;
  List<Covite> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }
}
