import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/lista-convites.dart';
import '../utils/app-routes.dart';
import '../widgets/drawer_widget.dart';

class ConviteScreen extends StatefulWidget {
  @override
  _ConviteScreenState createState() => _ConviteScreenState();
}

class _ConviteScreenState extends State<ConviteScreen> {
  @override
  Widget build(BuildContext context) {
    final inviteData = Provider.of<ListaConvite>(context);
    final invites = inviteData.items;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Convites Recebidos',
          style: TextStyle(color: Theme.of(context).primaryColorLight),
        ),
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: inviteData.itemsCount,
          itemBuilder: (ctx, i) => Column(children: <Widget>[
            ProductItem(invites[i]),
            //Divider(),
          ]),
        ),
        // Column(
        //   children: <Widget>[
        // TextButton.icon(
        //   label: Text(
        //     'Voltar',
        //     style: TextStyle(color: Theme.of(context).primaryColor),
        //   ),
        //   icon: Icon(
        //     Icons.arrow_back_ios,
        //     color: Theme.of(context).primaryColor,
        //   ),
        //   onPressed: () {
        //     Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
        //   },
        // ),
        // Divider(),
        //if convites == null 'sem convites' : List convites
      ),
    );
  }
}

class ProductItem extends StatefulWidget {
  final Covite product;

  ProductItem(this.product);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Icon(
                Icons.new_releases,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  widget.product.nome,
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: IconButton(
                  icon: Icon(
                    Icons.check,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).errorColor,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
