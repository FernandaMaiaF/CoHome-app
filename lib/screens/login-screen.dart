import 'package:flutter/material.dart';

import '../widgets/auth-card-widget.dart';
import '../widgets/drawer_widget.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
        ),
        Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 20.0),
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 70,
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
                child: Text(
                  'CoHome',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 45,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              AuthCard(),
            ],
          ),
        )
      ],
    ));
  }
}
