import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/userInfo1.dart';
import '../providers/auth1.dart';
import '../utils/app-routes.dart';
import '../widgets/drawer_widget.dart';

class PerfilScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserInfo>(context);
    final auth = Provider.of<Auth1>(context);

    Future<int> _getInvites() async {
      final responseCode =
          await user.getAndSaveUserInviteList(user.userId, auth.token);
      return responseCode;
    }

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
                      },
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
                    title: Text(user.nome),
                    subtitle: Text('Nome'),
                    dense: true,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.mail_outline,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(user.email),
                    subtitle: Text('email'),
                    dense: true,
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(user.dateBirth),
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
                      onPressed: () => {
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.SEGURANCA_FORM),
                      },
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
                    trailing: user.family == null
                        ? FlatButton.icon(
                            onPressed: () => {
                              Navigator.of(context)
                                  .pushReplacementNamed(AppRoutes.HOME),
                            },
                            color: Colors.grey[200],
                            icon: Icon(
                              Icons.add,
                              color: Theme.of(context).primaryColor,
                              size: 18,
                            ),
                            label: Text(
                              'Nova',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          )
                        : null,
                  ),
                  Divider(),
                  user.family == null
                      ? Container(
                          padding: EdgeInsets.all(10),
                          child: Text('Sem familia'),
                        )
                      : ListTile(
                          leading: Icon(
                            Icons.group_add,
                            color: Theme.of(context).primaryColor,
                          ),
                          title: Text(user.familyName),
                          subtitle: Text('Familia'),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.arrow_forward_ios_sharp,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacementNamed(AppRoutes.FAMILY_HOME);
                            },
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
                    title: Text('Ver meus convites'),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        _getInvites();
                        Navigator.of(context)
                            .pushReplacementNamed(AppRoutes.CONVITE_SCREEN);
                      },
                    ),
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
