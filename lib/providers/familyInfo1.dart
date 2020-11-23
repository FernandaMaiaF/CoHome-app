import 'dart:convert';
import 'package:app_tasks/exeptions/authexeption.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import "../utils/constants.dart";
import '../utils/constants.dart';

class FamilyInfo with ChangeNotifier {
  String familyId;
  String familyName;
  String buyListId;
  String taskListId;
  String adminId;

  List members;
  List buyList;
  List taskList;

  FamilyInfo();

  Future<void> getAndSaveFamilyData(
      String _familyId_, String _token_, bool _notify) async {
    final _urlData = Constants.BASE_API_URL + 'family/' + _familyId_;
    print("get " + _urlData);
    final response = await http.get(_urlData, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _token_
    });

    final responseData = json.decode(response.body);

    this.familyId = responseData["id"];
    this.familyName = responseData["name"];
    this.buyListId = responseData["buyList"];
    this.taskListId = responseData["taskList"];
    this.adminId = responseData["admin"];

    if (_notify) notifyListeners();

    return Future.value();
  }

  Future<int> createFamily(
      String _adminId, String _newFamilyName, String _token_) async {
    final _urlData = Constants.BASE_API_URL + 'family/';
    print("post " + _urlData);
    final reqBody = json.encode({"admin": _adminId, "name": _newFamilyName});
    final response = await http.post(_urlData,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _token_
        },
        body: reqBody);

    final responseData = json.decode(response.body);
    print(responseData);

    notifyListeners();
    return response.statusCode;
  }

  Future<int> deleteFamily(String _token_) async {
    final _urlData = Constants.BASE_API_URL + 'family/' + this.familyId;
    print("delete " + _urlData);

    final response = await http.delete(_urlData, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _token_
    });
    //print("with status code " + response);
    final responseData = json.decode(response.body);

    if (response.statusCode == 200) {
      this.familyId = null;
      this.familyName = null;
      this.buyListId = null;
      this.taskListId = null;
      this.adminId = null;
    }

    notifyListeners();
    return response.statusCode;
  }

  Future<int> getMembers(String _token_) async {
    this.members = [];

    final _urlData =
        Constants.BASE_API_URL + 'family/' + this.familyId + "/members";
    print("get " + _urlData);

    final response = await http.get(_urlData, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _token_
    });

    final responseData = json.decode(response.body);

    print(responseData);

    this.members = responseData["membersList"];

    print("LISTA MEMBROS " + this.members.toString());

    notifyListeners();
    return response.statusCode;
  }

  Future<int> sendInvite(String _email_, String _token_) async {
    buyList = [];

    final _urlData =
        Constants.BASE_API_URL + 'family/' + this.familyId + "/invite";

    print("post " + _urlData);

    final reqBody = json.encode({"email": _email_});

    final response = await http.post(_urlData,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _token_
        },
        body: reqBody);

    final responseData = json.decode(response.body);

    print(responseData);

    notifyListeners();
    return response.statusCode;
  }

  Future<int> getBuyList(String _token_) async {
    buyList = [];

    final _urlData =
        Constants.BASE_API_URL + 'family/' + this.familyId + "/buyList";

    print("get " + _urlData);

    final response = await http.get(_urlData, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _token_
    });

    final responseData = json.decode(response.body);

    buyList = responseData["products"];

    for (var _prod in buyList) {
      _prod["marked"] = false;
    }

    print("Get da lista de produtos " + responseData.toString());

    notifyListeners();
    return response.statusCode;
  }

  Future<int> createBuyItem(
      String newItemName, String newItemDesc, String _token_) async {
    final _urlData =
        Constants.BASE_API_URL + 'family/' + this.familyId + "/buyList";

    print("post " + _urlData);

    final reqBody = json.encode({
      "products": [
        {"productName": newItemName, "productDesc": newItemDesc}
      ]
    });
    final response = await http.post(_urlData,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _token_
        },
        body: reqBody);

    final responseData = json.decode(response.body);
    print(responseData);

    notifyListeners();
    return response.statusCode;
  }

  Future<int> changeBuyList(
      Map<String, dynamic> newBuyItens, String _token_) async {
    print("new itens : " + newBuyItens.toString());
    final _urlData =
        Constants.BASE_API_URL + 'family/' + this.familyId + "/buyList";

    print("patch " + _urlData);

    final reqBody = json.encode({"products": newBuyItens["products"]});
    final response = await http.patch(_urlData,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _token_
        },
        body: reqBody);

    final responseData = json.decode(response.body);

    /*
    if(response.statusCode == 200){
      _buyList = newBuyItens;
    }
    */

    notifyListeners();
    return response.statusCode;
  }

  Future<int> getTaskList(String _token_) async {
    taskList = [];

    final _urlData =
        Constants.BASE_API_URL + 'family/' + this.familyId + "/taskList";

    print("get " + _urlData);

    final response = await http.get(_urlData, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer " + _token_
    });

    final responseData = json.decode(response.body);

    taskList = responseData["tasks"];

    for (var _task in taskList) {
      _task["marked"] = false;
    }

    print("Get da lista de tarefas " + responseData.toString());

    notifyListeners();
    return response.statusCode;
  }

  Future<int> createTaskItem(String newTaskName, String _token_) async {
    final _urlData =
        Constants.BASE_API_URL + 'family/' + this.familyId + "/taskList";

    print("post " + _urlData);

    final reqBody = json.encode({
      "tasks": [
        {"taskName": newTaskName}
      ]
    });
    final response = await http.post(_urlData,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _token_
        },
        body: reqBody);

    final responseData = json.decode(response.body);
    print(responseData);

    notifyListeners();
    return response.statusCode;
  }

  Future<int> changeTaskList(
      Map<String, dynamic> newTaksItens, String _token_) async {
    print("new itens : " + newTaksItens.toString());
    final _urlData =
        Constants.BASE_API_URL + 'family/' + this.familyId + "/taskList";
    print("patch " + _urlData);

    final reqBody = json.encode({"tasks": newTaksItens["tasks"]});
    final response = await http.patch(_urlData,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer " + _token_
        },
        body: reqBody);

    final responseData = json.decode(response.body);

    /*
    if(response.statusCode == 200){
      _buyList = newBuyItens;
    }
    */

    notifyListeners();
    return response.statusCode;
  }
}
