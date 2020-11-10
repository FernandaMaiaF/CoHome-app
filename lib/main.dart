import 'package:flutter/material.dart';

import './utils/app-routes.dart';

import './screens/homepage-screen.dart';
import './screens/dados-pessoais-screen.dart';
import './screens/adicionar-familia-screen.dart';
import './screens/calendario-screen.dart';
import './screens/lista-compras-screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tasks',
      theme: ThemeData(
        primaryColor: Colors.teal[300],
        errorColor: Colors.red[400],
        primaryColorLight: Colors.grey[50],
      ),
      routes: {
        AppRoutes.HOME: (ctx) => HomePage(),
        AppRoutes.DADOS_PESSOAIS: (ctx) => DadosPessoaisScreen(),
        AppRoutes.ADICINAR_FAMILIA: (ctx) => AdicionarFailiaScreen(),
        AppRoutes.CALENDARIO_SCREEN: (ctx) => CalendarioScreen(),
        AppRoutes.LISTA_COMPRAS: (ctx) => ListaComprasScreen(),
      },
    );
  }
}
