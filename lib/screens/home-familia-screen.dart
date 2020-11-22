import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/app-routes.dart';
import '../providers/familyInfo1.dart';
import '../providers/userInfo1.dart';
import '../providers/auth1.dart';
import '../widgets/drawer_widget.dart';

class FamilyHomeScreen extends StatefulWidget {
  @override
  _FamilyHomeScreenState createState() => _FamilyHomeScreenState();
}

class _FamilyHomeScreenState extends State<FamilyHomeScreen> {
  @override
  Widget build(BuildContext context) {
    final familyInfo = Provider.of<FamilyInfo>(context, listen: false);
    final userInfo = Provider.of<UserInfo>(context, listen: false);
    final auth = Provider.of<Auth1>(context, listen: false);
    familyInfo.getAndSaveFamilyData(userInfo.family, auth.token, false);
    final deviceSize = MediaQuery.of(context).size;
    print("buildando family home");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CoHome',
          style: TextStyle(
            color: Theme.of(context).primaryColorLight,
          ),
        ),
      ),
      drawer: DrawerWidget(),
      body: CustomScrollView(slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                color: Colors.white,
                height: deviceSize.height * 0.08,
                width: deviceSize.width,
                alignment: Alignment.center,
                child: HeaderWidget('FAMÍLIA: ' + userInfo.familyName),
              ),
              Divider(),
            ],
          ),
        ),
        SliverGrid(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          delegate: SliverChildListDelegate(
            [
              BodyWidget("Ver Membros", AppRoutes.FAMILY_MEMBROS, Icons.people),
              BodyWidget("Ver Lista de Compras", AppRoutes.LISTA_COMPRAS,
                  Icons.shopping_cart),
              BodyWidget("Ver Lista de Tarefas", AppRoutes.LISTA_TAREFAS,
                  Icons.format_list_bulleted),
            ],
          ),
        ),
      ]),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String text;

  HeaderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10, bottom: 2, top: 20),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
      color: Colors.white,
    );
  }
}

class BodyWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String navigationKey;

  BodyWidget(this.title, this.navigationKey, this.icon);

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    final familyInfo = Provider.of<FamilyInfo>(context);
    final auth = Provider.of<Auth1>(context);

    Future<int> _getMembers() async {
      final responseCode = await familyInfo.getMembers(auth.token);
      return responseCode;
    }

    Future<int> _getBuyProducts() async {
      final responseCode = await familyInfo.getBuyList(auth.token);
      return responseCode;
    }

    Future<int> _getTaskList() async {
      final responseCode = await familyInfo.getTaskList(auth.token);
      return responseCode;
    }

    return Container(
        alignment: Alignment.center,
        child: Card(
          color: Theme.of(context).primaryColor,
          elevation: 5,
          child: InkWell(
            onTap: () {
              if (this.navigationKey == AppRoutes.FAMILY_MEMBROS)
                _getMembers();
              else if (this.navigationKey == AppRoutes.LISTA_COMPRAS)
                _getBuyProducts();
              else
                _getTaskList();
              Navigator.of(context).pushReplacementNamed(navigationKey);
            },
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      margin: EdgeInsets.only(top: 40),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: deviceSize.height * 0.10,
                      )),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    verticalDirection: VerticalDirection.up,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        color: Colors.black.withOpacity(.2),
                        child: Text(
                          title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
