import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/app-routes.dart';
import '../widgets/drawer_widget.dart';
import '../providers/lista-compras.dart';
import '../providers/familyInfo1.dart';
import '../providers/auth1.dart';
//import '../providers/lista-compras.dart';

import '../widgets/product-item.dart';

class ListaComprasScreen extends StatefulWidget {
  @override
  _ListaComprasScreenState createState() => _ListaComprasScreenState();
}

class _ListaComprasScreenState extends State<ListaComprasScreen> {
  @override
  Widget build(BuildContext context) {
    //final productsData = Provider.of<Lista>(context);
    final familyInfo = Provider.of<FamilyInfo>(context);
    final products = familyInfo.buyList;

    final auth = Provider.of<Auth1>(context);

    Future<void> _updateBuyList() async {
      Map<String, dynamic> finalProducts = {"products": []};
      List<Map<String, dynamic>> productsArrayInfo = [];

      for (var _product in familyInfo.buyList) {
        print("to aqui no " + _product.toString());
        if (!_product["marked"]) productsArrayInfo.add(_product);
      }

      finalProducts["products"] = productsArrayInfo;

      print(productsArrayInfo.toString());

      await familyInfo.changeBuyList(finalProducts, auth.token);

      await familyInfo.getBuyList(auth.token);

      Navigator.of(context).pushNamed(
        AppRoutes.LISTA_COMPRAS,
      );

      return Future.value();
    }

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
            onPressed: () => Navigator.of(context)
                .pushReplacementNamed(AppRoutes.LISTA_COMPRAS_FORM),
          ),
        ],
      ),
      drawer: DrawerWidget(),
      body: new Card(
        elevation: 6,
        child: ListView.builder(
          itemCount: familyInfo.buyList.length,
          itemBuilder: (ctx, i) => Column(children: <Widget>[
            ProductItem(products[i]),
            Divider(),
          ]),
        ),
      ),
      // floatingActionButton: new FloatingActionButton(
      //   tooltip: 'Add task',
      //   child: new Icon(Icons.add),
      //   backgroundColor: Theme.of(context).primaryColor,
      //   onPressed: () => Navigator.of(context)
      //       .pushReplacementNamed(AppRoutes.LISTA_COMPRAS_FORM),
      // ),
      bottomNavigationBar: Card(
        color: Theme.of(context).primaryColor,
        child: Row(
          children: [
            Expanded(
              child: TextButton.icon(
                icon: Icon(
                  Icons.campaign_rounded,
                  color: Theme.of(context).primaryColorLight,
                ),
                label: Text(
                  'Finalizar Compra',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                onPressed: () => _updateBuyList(),
              ),
            ),
            Container(
              padding: EdgeInsets.all(2),
              color: Colors.white,
              height: 27,
              width: 2,
            ),
            Expanded(
              child: TextButton.icon(
                icon: Icon(
                  Icons.add,
                  color: Theme.of(context).primaryColorLight,
                ),
                label: Text(
                  'Adicionar Item',
                  style: TextStyle(
                    color: Theme.of(context).primaryColorLight,
                  ),
                ),
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(AppRoutes.LISTA_COMPRAS_FORM),
              ),
            )
          ],
        ),
      ),
    );
  }
}
