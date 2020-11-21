import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth.dart';

import '../exeptions/authexeption.dart';

enum AuthMode { Signup, Login }

class AuthCard extends StatefulWidget {
  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  GlobalKey<FormState> _form = GlobalKey();
  bool _isLoading = false;
  AuthMode _authMode = AuthMode.Login;
  final _passwordController = TextEditingController();
  Map<String, String> _authData = {
    'name': '',
    'email': '',
    'password': '',
  };
  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text("'Ocorreu um erro"),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Fechar'),
                ),
              ],
            ));
  }

  Future<void> _submit() async {
    if (!_form.currentState.validate()) {
      return;
    }
    setState(() {
      _isLoading = true;
    });
    _form.currentState.save();

    Auth auth = Provider.of(context, listen: false);
    try {
      if (_authMode == AuthMode.Login) {
        print("saske1");
        await auth.login(_authData["email"], _authData["password"]);
      } else {
        print("saske2");
        await auth.signup(
            _authData["name"], _authData["email"], _authData["password"]);
      }
    } on AuthException catch (error) {
      _showErrorDialog(error.toString());
    } catch (error) {
      print("saskenaruto" + error.toString());
      _showErrorDialog("Ocorreu um erro inesperado!");
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _switchAuthMode() {
    if (_authMode == AuthMode.Login) {
      setState(() {
        _authMode = AuthMode.Signup;
      });
    } else {
      setState(() {
        _authMode = AuthMode.Login;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Card(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          height: _authMode == AuthMode.Login ? 330 : 470,
          width: deviceSize.width * 0.85,
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: Column(
              children: [
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Nome Completo'),
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value.isEmpty || value.length > 30) {
                              return "Nome inválido";
                            }
                            return null;
                          }
                        : null,
                    onSaved: (value) => _authData['name'] = value,
                  ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value.isEmpty || !value.contains('@')) {
                      return "Informe um e-mail válido";
                    }
                    return null;
                  },
                  onSaved: (value) => _authData['email'] = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Senha'),
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value.isEmpty || value.length < 5) {
                      return "Informe uma senha válida";
                    }
                    return null;
                  },
                  onSaved: (value) => _authData['password'] = value,
                ),
                if (_authMode == AuthMode.Signup)
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Confirmar Senha'),
                    obscureText: true,
                    validator: _authMode == AuthMode.Signup
                        ? (value) {
                            if (value != _passwordController.text) {
                              return "Senhas diferentes";
                            }
                            return null;
                          }
                        : null,
                  ),
                Spacer(),
                if (_isLoading)
                  CircularProgressIndicator()
                else
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
                    child: Text(
                      _authMode == AuthMode.Login ? 'ENTRAR' : 'REGISTRAR',
                    ),
                    onPressed: _submit,
                  ),
                FlatButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                    "ALERNAR P/ ${_authMode == AuthMode.Login ? 'REGISTRAR' : 'LOGIN'}",
                  ),
                  textColor: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
        ));
  }
}
