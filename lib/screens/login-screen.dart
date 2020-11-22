import 'package:flutter/material.dart';

import '../widgets/auth-card-widget.dart';
import '../widgets/drawer_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
        ),
        SingleChildScrollView(
          child: Container(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: deviceSize.width * 0.95,
                  margin: EdgeInsets.only(bottom: 20.0),
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: deviceSize.width * 0.15,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColorLight,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 8,
                          color: Colors.black26,
                          offset: Offset(0, 2),
                        )
                      ]),
                  child: Row(
                    children: [
                      Flexible(
                        child: Image(
                          image: AssetImage(
                            'assets/images/logo_cohome.png',
                          ),
                          //height: 100,
                          width: deviceSize.width * 0.14,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 15),
                      ),
                      Text(
                        'CoHome',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 45,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                AuthCard(),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
