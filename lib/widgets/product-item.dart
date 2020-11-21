import 'package:flutter/material.dart';

import '../providers/dados-compras.dart';

class ProductItem extends StatefulWidget {
  final Compra product;

  ProductItem(this.product);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    bool _value = widget.product.status;

    return ListTile(
      leading: Icon(
        Icons.shopping_bag,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(widget.product.titulo),
      subtitle: Text(widget.product.descricao),
      trailing: Checkbox(
        checkColor: Theme.of(context).primaryColorLight,
        activeColor: Theme.of(context).primaryColor,
        value: _value,
        onChanged: (bool newValue) {
          widget.product.toggleItem();
          setState(() {
            _value = newValue;
          });
        },
      ),
      dense: true,
    );
  }
}
