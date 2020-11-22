import 'package:flutter/material.dart';

import '../widgets/drawer_widget.dart';
import '../utils/app-routes.dart';
import 'package:provider/provider.dart';
import '../providers/userInfo1.dart';
import '../providers/familyInfo1.dart';
import '../providers/auth1.dart';

class MyData {
  String id = '';
  String nome = '';
  String membros = '';
  String senha = '';
}

class AdicionarFailiaScreen extends StatefulWidget {
  @override
  _AdicionarFailiaScreenState createState() => _AdicionarFailiaScreenState();
}

class _AdicionarFailiaScreenState extends State<AdicionarFailiaScreen> {
  TextEditingController nomeEditingController = TextEditingController();

  static var _focusNode = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static MyData data = new MyData();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _form = GlobalKey();
    bool _isLoading = false;
    String _nomeFamilia = '';
    Auth1 auth = Provider.of(context);
    UserInfo userInfo = Provider.of(context);
    FamilyInfo familyInfo = Provider.of(context);
    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.red]) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }

    Future<void> _submit() async {
      if (!_form.currentState.validate()) {
        return;
      }
      setState(() {
        _isLoading = true;
      });
      _form.currentState.save();

      final response = await familyInfo.createFamily(
          userInfo.userId, _nomeFamilia, auth.token);

      userInfo.changedInfo = response != 409;

      await userInfo.getAndSaveUserData(userInfo.userId, auth.token, true);
      await familyInfo.getAndSaveFamilyData(userInfo.family, auth.token, true);

      //if dados = dados pessoais
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pushReplacementNamed(AppRoutes.FAMILY_HOME);
    }

    void _submitDetails() {
      final FormState formState = _formKey.currentState;
      if (!formState.validate()) {
        showSnackBarMessage('Please enter correct data');
      } else {
        formState.save();
        print("Nome: ${data.nome}");

        showDialog(
            context: context,
            child: new AlertDialog(
              title: new Text("Atenção"),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    new Text("Tem certeza que deseja criar esta família?"),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Enviar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text(
                    'Retornar',
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastrar Família',
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
      ),
      drawer: DrawerWidget(),
      body: Container(
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
                  Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                controller: nomeEditingController,
                validator: (value) {
                  if (value.isEmpty || value.length > 30) {
                    return 'Nome inválido';
                  }
                  return null;
                },
                onSaved: (value) => _nomeFamilia = value,
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
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
