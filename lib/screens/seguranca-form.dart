import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/userInfo1.dart';
import '../providers/auth1.dart';

import '../widgets/drawer_widget.dart';
import '../utils/app-routes.dart';

class SegurancaFormScreen extends StatefulWidget {
  @override
  _SegurancaFormScreenState createState() => _SegurancaFormScreenState();
}

class _SegurancaFormScreenState extends State<SegurancaFormScreen> {
  final _passwordController = TextEditingController();
  final _oldpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserInfo>(context);
    final auth = Provider.of<Auth1>(context);
    GlobalKey<FormState> _form = GlobalKey();
    bool _isLoading = false;
    Map<String, String> _user = {
      'senhaAntiga': '',
      'senha': '',
    };

    Future<int> _submit() async {
      print("Tentando trocar senah com userId : " + user.userId);

      if (!_form.currentState.validate()) {
        return -1;
      }
      setState(() {
        _isLoading = true;
      });
      _form.currentState.save();
      //user.updateUserData(_user['senha']);

      final response = await user.updateUserPassword(
          _user["senhaAntiga"], _user["senha"], user.userId, auth.token);

      response == 200
          ? await showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text("Atenção!"),
                    content: Text('A senha foi alterada com sucesso.'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.FAMILY_MEMBROS);
                        },
                        child: Text(
                          'Fechar',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ))
          : await showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text("Atenção!"),
                    content:
                        Text('Ocorreu um erro. A sua senha não foi alterada.'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(ctx).pop();
                        },
                        child: Text(
                          'Fechar',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ));

      Navigator.of(context).pushReplacementNamed(AppRoutes.PERFIL);

      /*
      if (response == 200) {
        Navigator.of(context).pushReplacementNamed(AppRoutes.PERFIL);
      } else if (response == 409) {
        //avisar que a senha antiga passada não é igual a verdadeira
      } else {
        //voltar pro login (auth fail)
      }
      */

      setState(() {
        _isLoading = false;
      });

      return response;
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Segurança',
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
                          .pushReplacementNamed(AppRoutes.PERFIL);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Senha Atual'),
                    controller: _oldpasswordController,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return "Informe uma senha válida";
                      }
                      return null;
                    },
                    onSaved: (value) => _user['senhaAntiga'] = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Senha Nova'),
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || value.length < 5) {
                        return "Informe uma senha válida";
                      }
                      return null;
                    },
                    onSaved: (value) => _user['senha'] = value,
                  ),
                  TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Confirmar Senha Nova'),
                      obscureText: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return "Senhas diferentes";
                        }
                        return null;
                      }),
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
                    onPressed: _submit,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
