import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app-routes.dart';
import '../widgets/drawer_widget.dart';
import '../providers/lista-compras.dart';

import '../widgets/product-item.dart';

class ListaComprasScreen extends StatefulWidget {
  @override
  _ListaComprasScreenState createState() => _ListaComprasScreenState();
}

class _ListaComprasScreenState extends State<ListaComprasScreen> {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Lista>(context);
    final products = productsData.items;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Compras',
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(
                AppRoutes.LISTA_COMPRAS_FORM,
              );
            },
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: new Card(
        elevation: 6,
        child: ListView.builder(
          itemCount: productsData.itemsCount,
          itemBuilder: (ctx, i) => Column(children: <Widget>[
            ProductItem(products[i]),
            Divider(),
          ]),
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        tooltip: 'Add task',
        child: new Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.of(context)
            .pushReplacementNamed(AppRoutes.LISTA_COMPRAS_FORM),
      ),
    );
  }
}
