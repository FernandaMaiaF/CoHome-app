import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../providers/lista-convites.dart';

class InviteItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final inviteData = Provider.of<ListaConvite>(context);
    final invites = inviteData.items;
    return ListView.builder(
      itemCount: inviteData.itemsCount,
      itemBuilder: (ctx, i) => Column(children: <Widget>[
        ProductItem(invites[i]),
        Divider(),
      ]),
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
    return ListTile(
      leading: Icon(
        Icons.shopping_bag,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(widget.product.nome),
      dense: true,
    );
  }
}
