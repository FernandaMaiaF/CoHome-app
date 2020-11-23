import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:app_tasks/exeptions/authexeption.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import './userInfo1.dart';
import "../utils/constants.dart";

class Auth1 with ChangeNotifier {
  String _userId;
  String _token;

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

  Auth1();

  Future<void> signup(
      String name, String email, String password, String birthDate) async {
    const String _urlRoute = Constants.BASE_API_URL + "user/signup";

    final response = await http.post(
      _urlRoute,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'birthDate': birthDate
      }),
    );
    print(json.decode(response.body));

    final responseBody = json.decode(response.body);

    if (responseBody["error"] != null) {
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
  Future<int> login(
      String email, String password, BuildContext _context) async {
    const String _urlRoute = Constants.BASE_API_URL + "user/login";

    final response = await http.post(
      _urlRoute,
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

      UserInfo userInfo = Provider.of(_context, listen: false);
      userInfo.changedInfo = true;
      await userInfo.getAndSaveUserData(this._userId, this._token, true);

      //this.nome = responseBody["name"];

      print("user_id " + this._userId);
      //print("user_id pelo user info" + userInfo.userId);
      //print("saske2 " + responseBody["name"]);
      //print("saske3" + responseBody);
    }
    notifyListeners();
    return response.statusCode;
  }
  /*

  Future<void> isAuthorized() async {
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
  */

  Future<void> tryAutoLogin() async {
    if (this.isAuth) {
      print("Autenticado");
      return Future.value();
    }
    print("Nao autenticado");
  }

  bool mayLogout(bool canLogOut) {
    print("tentado deslogar");
    if (canLogOut) {
      print("setando token e userId null");
      this._token = null;
      this._userId = null;
    }
    //notifyListeners();
    return canLogOut;
  }

  Future<void> logout(BuildContext _context, String loginPageCode) {
    print("tentado deslogar");
    this._token = null;
    this._userId = null;
    notifyListeners();
    Navigator.of(_context).pushReplacementNamed(loginPageCode);
    return Future.value();
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
