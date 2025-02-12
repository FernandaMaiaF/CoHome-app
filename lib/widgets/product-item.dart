import 'package:app_tasks/providers/auth1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dados-compras.dart';
import '../providers/familyInfo1.dart';
import '../providers/auth1.dart';

class ProductItem extends StatefulWidget {
  final Map<String, dynamic> product;

  ProductItem(this.product);

  @override
  _ProductItemState createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    bool _value = widget.product["marked"];

    final familyInfo = Provider.of<FamilyInfo>(context);
    final auth = Provider.of<Auth1>(context);

    Future<void> _updateBuyList() async {
      Map<String, dynamic> finalProducts;
      List<Map<String, dynamic>> productsArrayInfo;

      for (var _product in familyInfo.buyList) {
        if (!_product["marked"])
          productsArrayInfo.add({
            "productName": _product["productName"],
            "productDesc": _product["productDesc"]
          });
      }

      finalProducts["products"] = productsArrayInfo;

      print(productsArrayInfo.toString());

      await familyInfo.changeBuyList(finalProducts, auth.token);

      await familyInfo.getBuyList(auth.token);

      return Future.value();
    }

    return ListTile(
      leading: Icon(
        Icons.shopping_bag,
        color: Theme.of(context).primaryColor,
      ),
      title: Text(widget.product["productName"]),
      subtitle: Text(widget.product["productDesc"]),
      trailing: Checkbox(
        checkColor: Theme.of(context).primaryColorLight,
        activeColor: Theme.of(context).primaryColor,
        value: _value,
        onChanged: (bool newValue) {
          print("clicou na caixinha, com parametro " + newValue.toString());

          setState(() {
            print("entrou no set");

            _value = newValue;
            widget.product["marked"] = newValue;
          });
        },
      ),
      dense: true,
    );
  }
}
