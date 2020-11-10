import 'package:flutter/foundation.dart';

class Shop with ChangeNotifier {
  final String id;
  final String titulo;
  final int quantia;
  final double descricao;

  Shop({
    this.id,
    @required this.titulo,
    @required this.quantia,
    @required this.descricao,
  });
}
