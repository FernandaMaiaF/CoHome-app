import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/lista-convites.dart';
import '../providers/userInfo1.dart';
import '../providers/auth1.dart';
import '../utils/app-routes.dart';
import '../widgets/drawer_widget.dart';

class ConviteScreen extends StatefulWidget {
  @override
  _ConviteScreenState createState() => _ConviteScreenState();
}

class _ConviteScreenState extends State<ConviteScreen> {
  @override
  Widget build(BuildContext context) {
    final inviteData = Provider.of<ListaConvite>(context);

    final userInfo = Provider.of<UserInfo>(context);
    final auth = Provider.of<Auth1>(context);

    final invites = userInfo.inviteList;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Convites Recebidos',
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        ),
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            TextButton.icon(
              label: Text(
                'Voltar',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              icon: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(AppRoutes.PERFIL);
              },
            ),
            Divider(),
            userInfo.inviteList.length == 0
                ? Text('Você não possui novos convites')
                : Expanded(
                    child: ListView.builder(
                      itemCount: userInfo.inviteList.length,
                      itemBuilder: (ctx, i) => Column(children: <Widget>[
                        ProductItem(invites[i]),
                      ]),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  final Map<String, dynamic> product;

  ProductItem(this.product);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<UserInfo>(context);
    final auth = Provider.of<Auth1>(context);

    Future<int> _getInvites() async {
      final responseCode =
          await userInfo.getAndSaveUserInviteList(userInfo.userId, auth.token);

      Navigator.of(context).pushReplacementNamed(AppRoutes.CONVITE_SCREEN);
      return responseCode;
    }

    Future<int> _acceptFamily(String _familyId) async {
      final responseCode =
          await userInfo.addUserToFamily(_familyId, auth.token);

      if (responseCode == 200) {
        await userInfo.getAndSaveUserData(userInfo.userId, auth.token, true);

        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Parabéns"),
                  content: Text('Você foi adicionado a familia!'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('Fechar'),
                    ),
                  ],
                ));

        _getInvites();
      } else if (responseCode == 409) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Atenção!"),
                  content: Text('Você já está cadastrado em uma família. '),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('Fechar'),
                    ),
                  ],
                ));

        _getInvites();
      } else if (responseCode == 404) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Atenção!"),
                  content: Text('Família não existe mais!'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('Fechar'),
                    ),
                  ],
                ));

        _getInvites();
      } else {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Atenção!"),
                  content: Text(
                      'Ocorreu um problema. Você não pode entrar na família'),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text('Fechar'),
                    ),
                  ],
                ));

        _getInvites();
      }

      return responseCode;
    }

    Future<int> _rejectFamily(String _familyId) async {
      final responseCode =
          await userInfo.deleteInvite(userInfo.userId, _familyId, auth.token);

      if (responseCode == 200) {
        await userInfo.getAndSaveUserData(userInfo.userId, auth.token, true);

        _getInvites();
      } else {
        _getInvites();
      }
      return responseCode;
    }

    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.new_releases,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  widget.product["familyName"],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: Text('Tem certeza?'),
                              content: Text('Gostaria de entrar para a ' +
                                  widget.product["familyName"]),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text(
                                      'Sim',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    onPressed: () {
                                      Navigator.of(ctx).pop(true);
                                      _acceptFamily(widget.product["familyId"]);
                                    }),
                                FlatButton(
                                    child: Text(
                                      'Não',
                                      style: TextStyle(
                                          color: Theme.of(context).errorColor),
                                    ),
                                    onPressed: () {
                                      Navigator.of(ctx).pop(false);
                                    })
                              ],
                            ));
                    // _acceptFamily(widget.product["familyId"]);
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                              title: Text('Tem certeza?'),
                              content: Text(
                                  'Gostaria de recusar o convite da ' +
                                      widget.product["familyName"]),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text(
                                      'Sim',
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                    onPressed: () {
                                      Navigator.of(ctx).pop(true);
                                      _rejectFamily(widget.product["familyId"]);
                                    }),
                                FlatButton(
                                    child: Text(
                                      'Não',
                                      style: TextStyle(
                                          color: Theme.of(context).errorColor),
                                    ),
                                    onPressed: () {
                                      Navigator.of(ctx).pop(false);
                                    })
                              ],
                            ));
                    // _rejectFamily(widget.product["familyId"]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
