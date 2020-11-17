import 'package:flutter/material.dart';
//import '../utils/app-routes.dart';
import '../widgets/drawer_widget.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    this.title,
    this.subtile,
    this.padding,
    this.value,
    this.onChanged,
  });

  final String title;
  final String subtile;
  final EdgeInsets padding;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: ListTile(
          leading: Icon(
            Icons.shopping_bag,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(title),
          subtitle: Text(subtile),
          trailing: Checkbox(
            checkColor: Theme.of(context).primaryColorLight,
            activeColor: Theme.of(context).primaryColor,
            value: value,
            onChanged: (bool newValue) {
              onChanged(newValue);
            },
          ),
          dense: true,
        ),
      ),
    );
  }
}

class ListaComprasScreen extends StatefulWidget {
  @override
  _ListaComprasScreenState createState() => _ListaComprasScreenState();
}

class _ListaComprasScreenState extends State<ListaComprasScreen> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    final List<String> itens = <String>['Arroz', 'Azeitona', 'Pão'];
    final List<String> descricao = <String>[
      '1 branco',
      '2 potes da verde',
      '10 paes frances'
    ];

    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Lista de Compras',
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
            ),
          ),
        ),
        drawer: DrawerWidget(),
        body: Container(
          child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: itens.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 6,
                  child: Column(children: [
                    LabeledCheckbox(
                        title: '${itens[index]}',
                        subtile: '${descricao[index]}',
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        value: _isSelected,
                        onChanged: (bool newValue) {
                          setState(() {
                            _isSelected = newValue;
                          });
                        }),
                  ]),
                );
              }),
        ));
  }
}
