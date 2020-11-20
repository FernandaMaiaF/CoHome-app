import 'package:flutter/foundation.dart';

class Compra with ChangeNotifier {
  final String id;
  final String titulo;
  bool status;
  final String descricao;

  Compra({
    this.id,
    @required this.titulo,
    this.status = false,
    @required this.descricao,
  });

  void toggleItem() {
    status = !status;
    notifyListeners();
  }
}
