import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app-routes.dart';
import '../widgets/drawer_widget.dart';
import '../providers/familyInfo1.dart';
import '../providers/auth1.dart';

import '../widgets/task-item.dart';

class ListaTarefasScreen extends StatefulWidget {
  @override
  _ListaTarefasScreenState createState() => _ListaTarefasScreenState();
}

class _ListaTarefasScreenState extends State<ListaTarefasScreen> {
  @override
  Widget build(BuildContext context) {
    final familyInfo = Provider.of<FamilyInfo>(context);
    final tasks = familyInfo.taskList;

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

      Navigator.of(context).pushNamed(
        AppRoutes.LISTA_TAREFAS,
      );

      return Future.value();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Tarefas',
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.LISTA_TAREFAS_FORM),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: new Card(
        elevation: 6,
        child: ListView.builder(
          itemCount: familyInfo.taskList.length,
          itemBuilder: (ctx, i) => Column(children: <Widget>[
            TaskItem(tasks[i]),
            Divider(),
          ]),
        ),
      ),
      // floatingActionButton: new FloatingActionButton(
      //   tooltip: 'Add task',
      //   child: new Icon(Icons.add),
      //   backgroundColor: Theme.of(context).primaryColor,
      //   onPressed: () => Navigator.of(context)
      //       .pushReplacementNamed(AppRoutes.LISTA_COMPRAS_FORM),
      // ),
      bottomNavigationBar: Card(
        color: Theme.of(context).primaryColor,
        child: Row(
          children: [
            Expanded(
              child: TextButton.icon(
                icon: Icon(
                  Icons.campaign_rounded,
                  color: Theme.of(context).primaryColorLight,
                ),
                label: Text(
                  'Finalizar Tarefas',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                onPressed: () => _updateTaskList(),
              ),
            ),
            Container(
              padding: EdgeInsets.all(2),
              color: Colors.white,
              height: 27,
              width: 2,
            ),
            Expanded(
              child: TextButton.icon(
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColorLight,
                ),
                label: Text(
                  'Adicionar Tarefa',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.LISTA_TAREFAS_FORM),
              ),
            )
          ],
        ),
      ),
    );
  }
}
