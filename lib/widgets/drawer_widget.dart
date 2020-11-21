import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';
import '../utils/app-routes.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auth>(context);
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
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      user.family == null
                                          ? 'Sem família'
                                          : 'Família',
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
                  Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
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
              Divider(),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text(
                  'Calendário',
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.CALENDARIO_SCREEN);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.list),
                title: Text(
                  'Minhas Tarefas',
                ),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.add_circle),
                title: Text(
                  'Criar Nova Tarefa',
                ),
                onTap: () {},
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text(
                  'Lista de Compras',
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.LISTA_COMPRAS);
                },
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.keyboard_return),
                title: Text(
                  'Sair',
                ),
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(AppRoutes.AUTH_HOME);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
