import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app-routes.dart';
import '../widgets/drawer_widget.dart';
import '../providers/dados-compras.dart';
import '../providers/lista-compras.dart';
import '../providers/familyInfo1.dart';
import '../providers/auth1.dart';

class ListFormScreen extends StatefulWidget {
  @override
  _ListFormScreenState createState() => _ListFormScreenState();
}

class _ListFormScreenState extends State<ListFormScreen> {
  bool _isSelected = false;

  final _tileFocusNode = FocusNode();
  final _quantiaFocusNode = FocusNode();
  final _descricaoFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final product = ModalRoute.of(context).settings.arguments as Compra;

      if (product != null) {
        _formData['id'] = product.id;
        _formData['title'] = product.titulo;
        _formData['description'] = product.descricao;
        _formData['status'] = product.status;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tileFocusNode.dispose();
    _quantiaFocusNode.dispose();
    _descricaoFocusNode.dispose();
  }

  void _saveForm() {
    var isValid = _form.currentState.validate();

    if (!isValid) {
      return;
    }
    _form.currentState.save();

    final product =
        Compra(titulo: _formData['title'], descricao: _formData['description']);

    final products = Provider.of<Lista>(context, listen: false);
    if (_formData['id'] == null) {
      products.addProduct(product);
    } else {
      products.updateProduct(product);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final familyInfo = Provider.of<FamilyInfo>(context);
    final auth = Provider.of<Auth1>(context);

    Future<void> _createProduct() async {
      var isValid = _form.currentState.validate();

      if (!isValid) {
        return;
      }
      _form.currentState.save();

      final responseCode = await familyInfo.createBuyItem(
          _formData['title'], _formData['description'], auth.token);

      if (responseCode == 201) {
        await familyInfo.getBuyList(auth.token);
        Navigator.of(context).pushNamed(
          AppRoutes.LISTA_COMPRAS,
        );
      }

      return Future.value();
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Adicionar Item',
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                print(_formData['title']);
                print(_formData['description']);
                _createProduct();
              },
            )
          ],
        ),
        drawer: DrawerWidget(),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: TextButton.icon(
                        label: Text(
                          'Voltar',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AppRoutes.LISTA_COMPRAS);
                        },
                      ),
                    ),
                    Expanded(
                      child: TextButton.icon(
                        label: Text(
                          'Salvar',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        icon: Icon(
                          Icons.save,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () {
                          print(_formData['title']);
                          print(_formData['description']);
                          _createProduct();
                        },
                      ),
                    ),
                  ],
                ),
                Divider(),
                TextFormField(
                  initialValue: _formData['title'],
                  decoration: new InputDecoration(
                    labelText: "Adicione um item a lista",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_tileFocusNode);
                  },
                  onSaved: (value) => _formData['title'] = value,
                  validator: (value) {
                    bool isEmpty = value.trim().isEmpty;
                    bool isInvalid = value.trim().length < 3;

                    if (isEmpty || isInvalid) {
                      return 'Informe um Título válido com no mínimo 3 caracteres!';
                    }
                    return null;
                  },
                ),
                Divider(),
                new TextFormField(
                  minLines: 1,
                  maxLines: 4,
                  maxLength: 100,
                  initialValue: _formData['description'],
                  decoration: new InputDecoration(
                    labelText: "Descrição",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  onSaved: (value) {
                    _formData['description'] = value;
                    _formData['status'] = false;
                    print('test1');
                    print(_formData['description']);
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
