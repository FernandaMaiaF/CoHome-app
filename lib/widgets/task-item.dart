import 'package:app_tasks/providers/auth1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dados-compras.dart';
import '../providers/familyInfo1.dart';
import '../providers/auth1.dart';

class TaskItem extends StatefulWidget {
  final Map<String, dynamic> tasks;

  TaskItem(this.tasks);

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    bool _value = widget.tasks["marked"];

    final familyInfo = Provider.of<FamilyInfo>(context);
    final auth = Provider.of<Auth1>(context);

    Future<void> _updateTaskList() async {
      Map<String, dynamic> finalTasks = {"tasks": []};
      List<Map<String, dynamic>> tasksArrayInfo = [];

      for (var _task in familyInfo.taskList) {
        print("to aqui no " + _task.toString());
        if (!_task["marked"]) tasksArrayInfo.add(_task);
      }

      finalTasks["tasks"] = tasksArrayInfo;

      print(tasksArrayInfo.toString());

      await familyInfo.changeTaskList(finalTasks, auth.token);

      await familyInfo.getTaskList(auth.token);

      /*
      Navigator.of(context).pushNamed(
        AppRoutes.LISTA_TAREFAS,
      );
      */

      return Future.value();
    }

    /*
    Future<void> _updateBuyList() async {
      Map<String, dynamic> finalProducts;
      List<Map<String, dynamic>> productsArrayInfo;

      for (var _task in familyInfo.taskList) {
        if (!_task["marked"])
          productsArrayInfo.add({
            "productName": _product["productName"],
            "productDesc": _product["productDesc"]
          });
      }

      finalProducts["tasks"] = productsArrayInfo;

      print(productsArrayInfo.toString());

      await familyInfo.changeBuyList(finalProducts, auth.token);

      await familyInfo.getBuyList(auth.token);

      return Future.value();
    }
    */

    return ListTile(
      leading: Icon(
        Icons.list,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(widget.tasks["taskName"]),
      //subtitle: Text(widget.tasks["productDesc"]),
      trailing: Checkbox(
        checkColor: Theme.of(context).primaryColorLight,
        activeColor: Theme.of(context).primaryColor,
        value: _value,
        onChanged: (bool newValue) {
          print("clicou na caixinha, com parametro " + newValue.toString());

          setState(() {
            print("entrou no set");

            _value = newValue;
            widget.tasks["marked"] = newValue;
          });
        },
      ),
      dense: true,
    );
  }
}
