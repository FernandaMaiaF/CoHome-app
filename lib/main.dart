import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './utils/app-routes.dart';

import './screens/homepage-screen.dart';
import './screens/dados-pessoais-screen.dart';
import './screens/adicionar-familia-screen.dart';
import './screens/calendario-screen.dart';
import './screens/lista-compras-screen.dart';
import './screens/lista-form-screen.dart';
import './screens/login-screen.dart';

import './providers/lista-compras.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Lista(),
        ),
      ],
      child: MaterialApp(
        title: 'Tasks',
        theme: ThemeData(
          primaryColor: Colors.teal[300],
          errorColor: Colors.red[400],
          primaryColorLight: Colors.grey[50],
        ),
        routes: {
          AppRoutes.HOME: (ctx) => HomePage(),
          AppRoutes.LOGIN: (ctx) => LoginScreen(),
          AppRoutes.DADOS_PESSOAIS: (ctx) => DadosPessoaisScreen(),
          AppRoutes.ADICINAR_FAMILIA: (ctx) => AdicionarFailiaScreen(),
          AppRoutes.CALENDARIO_SCREEN: (ctx) => CalendarioScreen(),
          AppRoutes.LISTA_COMPRAS: (ctx) => ListaComprasScreen(),
          AppRoutes.LISTA_COMPRAS_FORM: (ctx) => ListFormScreen(),
        },
      ),
    );
  }
}
