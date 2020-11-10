import 'package:flutter/material.dart';

import '../widgets/drawer_widget.dart';

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
  int _currentStep = 0;
  final _formKeyFirstStep = GlobalKey<FormState>();

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
    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.red]) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }

    void _submitDetails() {
      final FormState formState = _formKey.currentState;
      print('teste3.1');
      if (!formState.validate()) {
        print('teste3.2');
        showSnackBarMessage('Please enter correct data');
      } else {
        print('teste3.3');
        formState.save();
        print("Nome: ${data.nome}");
        print("Senha: ${data.senha}");
        print("Membros: ${data.membros}");

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
      body: ListView(
        children: [
          Stepper(
            steps: <Step>[
              Step(
                title: Text('Nome da Família'),
                state: StepState.indexed,
                content: Form(
                  key: _formKeyFirstStep,
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Nome da Familia',
                        ),
                        onSaved: (String value) {
                          data.nome = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Campo Obrigatório, a senha deve ter no mínimo 4 digitos';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: 'Senha para ingressar',
                        ),
                        onChanged: (String value) {
                          data.senha = value;
                        },
                        validator: (value) {
                          if (value.isEmpty || value.length > 20) {
                            return 'Campo Obrigatório, a senha deve ter no mínimo 4 digitos';
                          }
                          return null;
                        },
                      ),
                      DropdownButtonFormField(
                        decoration: InputDecoration(
                          labelText: 'Número de Membros da Família',
                        ),
                        icon: Icon(Icons.arrow_downward),
                        elevation: 6,
                        items: <String>[
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String value) {
                          data.membros = value;
                        },
                        validator: (value) {
                          if (data.membros.isEmpty) {
                            return 'Campo Obrigatório';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
            type: StepperType.vertical,
            currentStep: this._currentStep,
            onStepContinue: () {
              if (_formKeyFirstStep.currentState.validate()) {
                print('teste1');
                setState(() {
                  print('teste2');
                  _submitDetails();
                  print('teste3');
                });
              } else {
                print('nao foooiiii');
              }
            },
          ),
        ],
      ),
    );
  }
}
