import 'dart:convert';
import 'package:app_tasks/exeptions/authexeption.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RequestControlProvider {
  final bool requestSuccess;

  RequestControlProvider({
    @required this.requestSuccess,
  });
}

class Auth with ChangeNotifier {
  String _userId;
  String _token;
  String nome;
  String email;
  String dataNascimento;
  String family;
  String invites;

  String get fullName {
    return nome;
  }

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return isAuth ? _userId : null;
  }

  String get token {
    if (_token != null) {
      return _token;
    } else {
      return null;
    }
  }

  Auth();

  static const _urlsignup = 'http://192.168.1.113:3000/user/signup';
  static const _urllogin = 'http://192.168.1.113:3000/user/login';

  Future<void> signup(String name, String email, String password) async {
    final response = await http.post(
      _urlsignup,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    print(json.decode(response.body));

    final responseBody = json.decode(response.body);

    if (responseBody["error" != null]) {
      throw AuthException(responseBody['error']['message']);
    } else {
      // Store.saveMap('userData', {
      //   "token": _token,
      //   "userId": _userId,
      //   "expiryDate": _expiryDate.toIso8601String(),
      // });

      //_autoLogout();
      notifyListeners();
    }

    return Future.value();
  }

//  "Authorization": "Bearer " + _token
  Future<void> login(String email, String password) async {
    print("abublube " + email);
    print("sdfjfgbdnfjsd " + password);
    final response = await http.post(
      _urllogin,
      headers: {
        "Content-Type": "application/json",
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    print(json.decode(response.body));

    final responseBody = json.decode(response.body);
    if (responseBody["error"] != null) {
      print(responseBody['error']['message']);
      throw AuthException(responseBody['error']['message']);
    } else {
      this._token = responseBody["token"];
      this._userId = responseBody["id"];

      userData();

      //this.nome = responseBody["name"];

      print("user_id " + this._userId);
      //print("saske2 " + responseBody["name"]);
      //print("saske3" + responseBody);
    }
    notifyListeners();
    return Future.value();
  }

  Future<void> userData() async {
    final _urlData = 'http://192.168.1.113:3000/user/' + this._userId;
    print(_urlData);
    final response = await http.get(_urlData, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + this._token
    });

    final responseData = json.decode(response.body);

    this.nome = responseData["name"];
    this.email = responseData["email"];
    this.family = responseData["family"];
    this.invites = responseData["invites"];

    print("user_name " + this.nome);
    print("user_family " + this.family);

    return Future.value();
  }

  Future<void> tryAutoLogin() async {
    if (isAuth) {
      print("Autenticado");
      return Future.value();
    }
    print("deu ruim");
  }
}

// class Store {
//   static Future<void> saveString(String key, String value) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.setString(key, value);
//   }

//   static Future<void> saveMap(String key, Map<String, dynamic> value) async {
//     saveString(key, json.encode(value));
//   }

//   static Future<String> getString(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString(key);
//   }

//   static Future<Map<String, dynamic>> getMap(String key) async {
//     try {
//       Map<String, dynamic> map = json.decode(await getString(key));
//       return map;
//     } catch (_) {
//       return null;
//     }
//   }

//   static Future<bool> remove(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.remove(key);
//   }
// }
