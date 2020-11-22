import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth1.dart';
import '../providers/userInfo1.dart';
import '../providers/familyInfo1.dart';
import '../widgets/drawer_widget.dart';
import '../utils/app-routes.dart';

class ConviteFormScreen extends StatefulWidget {
  @override
  _ConviteFormScreenState createState() => _ConviteFormScreenState();
}

class _ConviteFormScreenState extends State<ConviteFormScreen> {
  TextEditingController nomeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _form = GlobalKey();
    bool _isLoading = false;
    Map<String, String> _convite = {
      'nome': '',
    };

    final userInfo = Provider.of<UserInfo>(context);
    final auth = Provider.of<Auth1>(context);
    final familyInfo = Provider.of<FamilyInfo>(context);

    Future<void> _submit() async {
      if (!_form.currentState.validate()) {
        return;
      }
      setState(() {
        _isLoading = true;
      });
      _form.currentState.save();

      final response =
          await familyInfo.sendInvite(_convite['nome'], auth.token);
      print(response);
      response == 200
          ? showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text("Atenção!"),
                    content: Text('O convite foi enviado.'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Text('Testando fechar');
                          Navigator.of(ctx).pop();
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.FAMILY_MEMBROS);
                        },
                        child: Text('Fechar'),
                      ),
                    ],
                  ))
          : response == 409
              ? showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: Text("Atenção!"),
                        content: Text(
                            'O usuário já recebeu um convite para esta família.'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Text('Testando fechar');
                              Navigator.of(ctx).pop();
                              Navigator.of(context).pushReplacementNamed(
                                  AppRoutes.FAMILY_MEMBROS);
                            },
                            child: Text(
                              'Fechar',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ))
              : showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: Text("Atenção!"),
                        content: Text('Ocorreu um erro.'),
                        actions: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Text('Testando fechar');
                              Navigator.of(ctx).pop();
                              Navigator.of(context).pushReplacementNamed(
                                  AppRoutes.FAMILY_MEMBROS);
                            },
                            child: Text(
                              'Fechar',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ));
      setState(() {
        _isLoading = false;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Convidar Membro',
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
        ),
        drawer: DrawerWidget(),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _form,
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
                      Navigator.of(context)
                          .pushReplacementNamed(AppRoutes.FAMILY_MEMBROS);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'E-mail'),
                    controller: nomeEditingController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Nome inválido';
                      }
                      return null;
                    },
                    onSaved: (value) => _convite['nome'] = value,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                  ),
                  RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).primaryColorLight,
                      padding: EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 8,
                      ),
                      child: Text('CONTINUAR'),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                                  title: Text('Tem certeza?'),
                                  content: Text(
                                      'Gostaria de enviar o convite para ' +
                                          nomeEditingController.text),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        'Sim',
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor),
                                      ),
                                      onPressed: () {
                                        _submit();
                                        Navigator.of(ctx).pop();
                                        // Navigator.of(context)
                                        //     .pushReplacementNamed(
                                        //         AppRoutes.FAMILY_MEMBROS);
                                      },
                                    ),
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
                                ));
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
