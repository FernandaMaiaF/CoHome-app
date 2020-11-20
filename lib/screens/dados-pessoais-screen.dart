import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/user-provider.dart';

import '../widgets/drawer_widget.dart';
import '../utils/app-routes.dart';

class DadosPessoaisScreen extends StatefulWidget {
  @override
  _DadosPessoaisScreenState createState() => _DadosPessoaisScreenState();
}

class _DadosPessoaisScreenState extends State<DadosPessoaisScreen> {
  TextEditingController nomeEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController nascimentoEditingController = TextEditingController();

  DateTime selectedDate = new DateTime(2020);

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        initialDatePickerMode: DatePickerMode.year,
        context: context,
        initialDate: new DateTime.now(),
        firstDate: new DateTime.now().subtract(Duration(days: 54750)),
        lastDate: new DateTime.now());

    print(selectedDate);
    nascimentoEditingController.text = DateFormat('dd/MM/yyyy').format(picked);
    setState(() => selectedDate = picked);
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _form = GlobalKey();
    bool _isLoading = false;
    Map<String, String> _user = {
      'nome': 'Fernanda Maia',
      'email': 'teste@123',
      'nascimento': '14/11/1999',
    };

    void _submit() {
      if (!_form.currentState.validate()) {
        return;
      }
      setState(() {
        _isLoading = true;
      });
      _form.currentState.save();

      //if dados = dados pessoais
      setState(() {
        _isLoading = false;
      });
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Dados Pessoais',
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
                    decoration: InputDecoration(labelText: 'Nome'),
                    controller: nomeEditingController,
                    validator: (value) {
                      if (value.isEmpty || value.length > 30) {
                        return 'Nome deve ter no máximo 30 caracteres';
                      }
                      return null;
                    },
                    onSaved: (value) => _user['nome'] = value,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Email'),
                    controller: emailEditingController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return "Informe um e-mail válido";
                      }
                      return null;
                    },
                    onSaved: (value) => _user['email'] = value,
                  ),
                  InkWell(
                    onTap: () => _selectDate(context),
                    child: IgnorePointer(
                      child: TextFormField(
                        controller: nascimentoEditingController,
                        decoration: InputDecoration(
                          labelText: 'Nascimento',
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        onSaved: (value) => _user['nascimento'] = value,
                      ),
                    ),
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
        ));
  }
}
