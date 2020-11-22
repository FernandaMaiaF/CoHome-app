import 'package:app_tasks/screens/home-familia-screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth1.dart';
import '../providers/userInfo1.dart';
import 'login-screen.dart';
import 'homepage-screen.dart';

class AuthOrHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Auth1 auth = Provider.of(context);

    UserInfo userInfo = Provider.of(context);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return Center(child: Text('Ocorreu um erro!'));
        } else {
          return auth.isAuth
              ? (userInfo.family == null ? HomePage() : FamilyHomeScreen())
              : LoginScreen();
        }
      },
    );
  }
}

/*
if (auth.isAuth) {
            if (userInfo.family != null) {
              familyInfo.getAndSaveFamilyData(userInfo.family, auth.token);
              return FamilyHomeScreen();
            } else {
              return HomePage();
            }
          } else {
            return LoginScreen();
          }
*/
