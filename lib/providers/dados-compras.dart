import 'package:flutter/foundation.dart';

class Compra with ChangeNotifier {
  final String id;
  final String titulo;
  final bool status;
  final String descricao;

  Compra({
    this.id,
    @required this.titulo,
    @required this.status,
    @required this.descricao,
  });
}
