import 'package:flutter/material.dart';

import '../utils/app-routes.dart';
import '../widgets/drawer_widget.dart';

class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Perfil',
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
      ),
      drawer: DrawerWidget(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              elevation: 6,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Dados Pessoais'),
                    trailing: FlatButton.icon(
                      onPressed: () => {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.DADOS_PESSOAIS),
                      }, //_changeFamilycontext,user),
                      color: Colors.grey[200],
                      icon: Icon(
                        Icons.edit,
                        color: Theme.of(context).primaryColor,
                        size: 18,
                      ),
                      label: Text(
                        'Editar',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('User.nome'),
                    subtitle: Text('Nome'),
                    dense: true,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.mail_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('user.email'),
                    subtitle: Text('email'),
                    dense: true,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('user.nascimento'),
                    subtitle: Text('Nascimento'),
                    dense: true,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              elevation: 6,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Segurança'),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.lock,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('******'),
                    subtitle: Text('Senha'),
                    trailing: FlatButton(
                      onPressed: () =>
                          {}, //_changePasswordDialog(context,user),
                      child: Text(
                        'Alterar',
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    ),
                    dense: true,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              elevation: 6,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Família'),
                    trailing: FlatButton.icon(
                      onPressed: () => {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.HOME),
                      }, //_changeFamilycontext,user),
                      color: Colors.grey[200],
                      icon: Icon(
                        Icons.add,
                        color: Theme.of(context).primaryColor,
                        size: 18,
                      ),
                      label: Text(
                        'Nova',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.group_add,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('user.familiax'),
                    subtitle: Text('Familia'),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {},
                    ),
                    dense: true,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              margin: EdgeInsets.all(5),
              elevation: 6,
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text('Convites'),
                    subtitle: Text('(Somente administrador)'),
                    trailing: FlatButton.icon(
                      onPressed: () => {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.HOME),
                      }, //_changeFamilycontext,user),
                      color: Colors.grey[200],
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context).primaryColor,
                        size: 18,
                      ),
                      label: Text(
                        'Enviar Convite',
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.new_releases,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text('Familia'),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Theme.of(context).primaryColor,
                        size: 18,
                      ),
                      onPressed: () {},
                    ),
                    dense: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
