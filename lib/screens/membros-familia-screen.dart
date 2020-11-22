import 'package:flutter/material.dart';
import '../utils/app-routes.dart';
import 'package:provider/provider.dart';
// import '../providers/family-provider.dart';
import '../providers/familyInfo1.dart';
import '../providers/auth1.dart';
import '../widgets/drawer_widget.dart';

class MembrosFamiliaScreen extends StatefulWidget {
  @override
  _MembrosFamiliaScreenState createState() => _MembrosFamiliaScreenState();
}

class _MembrosFamiliaScreenState extends State<MembrosFamiliaScreen> {
  @override
  Widget build(BuildContext context) {
    //final membros = Provider.of<ListaMembros>(context);
    final familyInfo = Provider.of<FamilyInfo>(context);
    final auth = Provider.of<Auth1>(context);

    final pessoas = familyInfo.members;

    print("PESSOAS CU " + pessoas.toString());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Membros da Família',
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        ),
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(children: [
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
              Navigator.of(context).pushReplacementNamed(AppRoutes.FAMILY_HOME);
            },
          ),
          ListTile(
            title: Text(
              'Membros',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            trailing: FlatButton.icon(
              color: Colors.grey[200],
              onPressed: () {
                Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.CONVITE_FORM);
              },
              icon: Icon(
                Icons.send,
                color: Theme.of(context).primaryColor,
                size: 18,
              ),
              label: Text(
                'Convidar',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: familyInfo.members.length,
              itemBuilder: (ctx, i) => Column(children: <Widget>[
                ProductItem(pessoas[i], i),
              ]),
            ),
          )
        ]),
      ),
      bottomNavigationBar: Card(
        color: Theme.of(context).errorColor,
        child: Row(
          children: [
            Expanded(
              child: TextButton.icon(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Theme.of(context).primaryColorLight,
                  ),
                  label: Text(
                    'Sair da Família',
                    style: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  onPressed: () => {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: Text('Tem certeza?'),
                                  content: Text('Gostaria de sair da família ' +
                                      familyInfo.familyName),
                                  actions: <Widget>[
                                    FlatButton(
                                        child: Text(
                                          'Sim',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        onPressed: () {
                                          Navigator.of(ctx).pop(true);
                                        }),
                                    FlatButton(
                                        child: Text(
                                          'Não',
                                          style: TextStyle(
                                              color:
                                                  Theme.of(context).errorColor),
                                        ),
                                        onPressed: () {
                                          Navigator.of(ctx).pop(false);
                                        })
                                  ],
                                )),
                      }),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  final String pessoa;
  final int pessoaPos;

  ProductItem(this.pessoa, this.pessoaPos);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    final familyInfo = Provider.of<FamilyInfo>(context);
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: Icon(
            Icons.person,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(
            widget.pessoa,
            style: TextStyle(fontSize: 16),
          ),
          trailing: widget.pessoaPos == 0
              ? Text(
                  'ADMIN',
                  style: TextStyle(color: Theme.of(context).errorColor),
                )
              : Text(''),
          dense: true,
        ),
      ),
    );
  }
}
