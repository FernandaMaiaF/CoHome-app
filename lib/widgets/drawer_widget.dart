import 'package:app_tasks/providers/userInfo1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth1.dart';
import '../providers/userInfo1.dart';
import '../providers/familyInfo1.dart';
import '../utils/app-routes.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final authInfo = Provider.of<Auth1>(context);
    final user = Provider.of<UserInfo>(context);
    final familyInfo = Provider.of<FamilyInfo>(context);

    Future<void> _getFamilyInfo() async {
      Navigator.of(context).pushReplacementNamed(AppRoutes.FAMILY_HOME);
      return Future.value();
    }

    Future<int> _getBuyProducts() async {
      final responseCode = await familyInfo.getBuyList(authInfo.token);
      Navigator.of(context).pushReplacementNamed(AppRoutes.LISTA_COMPRAS);
      return responseCode;
    }

    Future<int> _getTaskList() async {
      final responseCode = await familyInfo.getTaskList(authInfo.token);
      Navigator.of(context).pushReplacementNamed(AppRoutes.LISTA_TAREFAS);
      return responseCode;
    }

    return ConstrainedBox(
      constraints: const BoxConstraints.expand(width: 304),
      child: Material(
        elevation: 16,
        child: Container(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).padding.top + 100.0,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsetsDirectional.only(top: 11),
                child: SafeArea(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.person),
                              backgroundColor:
                                  Theme.of(context).primaryColorLight,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.nome,
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      user.family == null
                                          ? 'Sem família'
                                          : user.familyName,
                                      style: TextStyle(
                                        color:
                                            Theme.of(context).primaryColorLight,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ))
                  ],
                )),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text(
                  'Home Page',
                ),
                onTap: () {
                  if (user.family != null) {
                    _getFamilyInfo();
                  } else {
                    Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
                  }
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.edit),
                title: Text(
                  'Editar Perfil',
                ),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.PERFIL);
                },
              ),

              if (user.family != null) Divider(),
              if (user.family != null)
                ListTile(
                  leading: Icon(Icons.shopping_cart),
                  title: Text(
                    'Lista de Compras',
                  ),
                  onTap: () {
                    if (user.family != null) {
                      _getBuyProducts();
                    } else {
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.HOME);
                    }
                  },
                ),
              if (user.family != null) Divider(),
              if (user.family != null)
                ListTile(
                  leading: Icon(Icons.list),
                  title: Text(
                    'Lista de Tarefas',
                  ),
                  onTap: () {
                    _getTaskList();
                  },
                ),

              Divider(),
              // ListTile(
              //   leading: Icon(Icons.list),
              //   title: Text(
              //     'Minhas Tarefas',
              //   ),
              //   onTap: () {},
              // ),
              // Divider(),
              // ListTile(
              //   leading: Icon(Icons.add_circle),
              //   title: Text(
              //     'Criar Nova Tarefa',
              //   ),
              //   onTap: () {},
              // ),
              // Divider(),
              ListTile(
                leading: Icon(Icons.keyboard_return),
                title: Text(
                  'Sair',
                ),
                onTap: () {
                  authInfo.logout(context, AppRoutes.AUTH_HOME);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
