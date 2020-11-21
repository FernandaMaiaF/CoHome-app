import 'package:flutter/material.dart';

import '../utils/app-routes.dart';
import '../widgets/drawer_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80.0,
                height: 80.0,
                child: FloatingActionButton(
                  heroTag: 1,
                  child: Icon(
                    Icons.add,
                    size: 40,
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.ADICINAR_FAMILIA);
                  },
                ),
              ),
              Text(
                'Criar Família',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.all(30),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80.0,
                height: 80.0,
                child: FloatingActionButton(
                  heroTag: 2,
                  child: Icon(
                    Icons.arrow_forward,
                    size: 40,
                  ),
                  backgroundColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(AppRoutes.CONVITE_SCREEN);
                  },
                ),
              ),
              Text(
                'Ver Convites',
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
