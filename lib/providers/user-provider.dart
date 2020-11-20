import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  final String id;
  final String nomeCompleto;
  final String email;
  final String nascimento;

  bool loggedIn = false;

  User({
    this.id,
    @required this.nomeCompleto,
    @required this.email,
    @required this.nascimento,
  });
}

final USERS = [
  User(
    id: 'p1',
    nomeCompleto: 'Fernanda Maia',
    email: 'teste@123',
    nascimento: '14/11/1999',
  ),
];

class Lista with ChangeNotifier {
  List<User> _users = USERS;
  List<User> get users => [..._users];

  int get itemsCount {
    return _users.length;
  }

  void addUser(User newPessoa) {
    // const url = '';
    // http.post(url,body: null);

    _users.add(User(
      id: Random().nextDouble().toString(),
      nomeCompleto: newPessoa.nomeCompleto,
      email: newPessoa.email,
      nascimento: newPessoa.nascimento,
    ));
    notifyListeners();
  }

  //atualiza os produtos depois de salvar
  void updateUser(User pessoa) {
    if (pessoa == null || pessoa.id == null) {
      return;
    }

    final index = _users.indexWhere((pessoa) => pessoa.id == pessoa.id);
    if (index >= 0) {
      _users[index] = pessoa;
      notifyListeners();
    }
  }

  void deleteUser(String id) {
    final index = _users.indexWhere((pessoa) => pessoa.id == id);
    if (index >= 0) {
      _users.removeWhere((pessoa) => pessoa.id == id);
      notifyListeners();
    }
  }
}
