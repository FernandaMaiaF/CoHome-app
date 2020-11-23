import 'dart:convert';
import 'package:app_tasks/exeptions/authexeption.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../utils/constants.dart';
import '../utils/constants.dart';

class UserInfo with ChangeNotifier {
  String userId;
  String nome;
  String email;
  String dateBirth;
  String family;
  String familyName;
  String inviteListId;

  List inviteList;

  bool changedInfo = false;

  String get fullName {
    return nome;
  }

  UserInfo();

  Future<void> getAndSaveUserData(
      String _userId_, String _token_, bool _notify) async {
    if (changedInfo) {
      print("fimose");
      final _urlData = Constants.BASE_API_URL + 'user/' + _userId_;

      print("get " + _urlData);
      final response = await http.get(_urlData, headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + _token_
      });

      final responseData = json.decode(response.body);

      print("AGORA VAI SEU SAFADO " + responseData.toString());

      this.userId = responseData["id"];
      this.nome = responseData["name"];
      this.email = responseData["email"];
      this.family = responseData["family"];
      this.familyName = responseData["familyName"];
      this.inviteListId = responseData["invites"];
      this.dateBirth = responseData["birthDate"];
      this.changedInfo = false;
    }

    //print("user_name " + this.nome);
    //print("user_family " + this.family);

    if (_notify) notifyListeners();
    return Future.value();
  }

  Future<void> updateUserData(
      String _newUserName, String _newDate, String _token_) async {
    print("patch arg1 " +
        _newUserName +
        " patch arg2 " +
        _newDate +
        " patch arg3 " +
        _token_);
    final _urlData = Constants.BASE_API_URL + 'user/' + this.userId;
    print("patch " + _urlData);
    final reqBody = json.encode({"name": _newUserName, "birthDate": _newDate});
    final response = await http.patch(_urlData,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _token_
        },
        body: reqBody);

    print(response.statusCode);

    this.changedInfo = true;

    notifyListeners();
    return Future.value();
    //return response.statusCode;
  }

  Future<int> updateUserPassword(
      String _oldPw, String _newPw, String _userId_, String _token_) async {
    final _urlData = Constants.BASE_API_URL + 'user/' + _userId_ + "/pw";
    print("patch " + _urlData);
    final reqBody = json.encode({"oldPassword": _oldPw, "newPassword": _newPw});
    final response = await http.patch(_urlData,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _token_
        },
        body: reqBody);

    print(response.statusCode);

    //this.changedInfo = true;

    notifyListeners();

    return response.statusCode;
  }

  Future<int> addUserToFamily(String _familyId_, String _token_) async {
    final _urlData =
        Constants.BASE_API_URL + 'family/' + _familyId_ + "/members";
    print("post " + _urlData);

    final reqBody = json.encode({"userId": this.userId});
    final response = await http.post(_urlData,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _token_
        },
        body: reqBody);

    final responseData = json.decode(response.body);
    print(responseData);

    if (response.statusCode == 200) this.changedInfo = true;

    notifyListeners();
    return response.statusCode;
  }

  Future<int> getAndSaveUserInviteList(String _userId_, String _token_) async {
    final _urlData = Constants.BASE_API_URL + 'user/' + _userId_ + '/invites';
    print("get " + _urlData);
    final response = await http.get(_urlData, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _token_
    });

    final responseData = json.decode(response.body);

    print("Get da lista de convites " + responseData.toString());

    this.inviteList = responseData["invites"];
    //this.changedInfo = true;

    //print("user_name " + this.nome);
    //print("user_family " + this.family);

    notifyListeners();
    return Future.value();
  }

  Future<int> deleteInvite(
      String _userId_, String _familyId, String _token_) async {
    final _urlData =
        Constants.BASE_API_URL + 'user/' + _userId_ + '/invites/' + _familyId;
    print("delete " + _urlData);

    //final reqBody = json.encode({"familyId": _familyId});

    final response = await http.delete(_urlData, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _token_
    });

    final responseData = json.decode(response.body);

    print("Delete da lista de convites " + responseData.toString());
    //this.changedInfo = true;

    //print("user_name " + this.nome);
    //print("user_family " + this.family);

    notifyListeners();
    return Future.value();
  }
}
