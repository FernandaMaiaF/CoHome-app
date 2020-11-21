import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './utils/app-routes.dart';

import './screens/auth-home-screen.dart';
import './screens/homepage-screen.dart';
import 'screens/perfil-screen.dart';
import './screens/dados-pessoais-screen.dart';
import './screens/adicionar-familia-screen.dart';
import './screens/calendario-screen.dart';
import './screens/lista-compras-screen.dart';
import './screens/lista-form-screen.dart';
import './screens/convites-screen.dart';

import './providers/lista-compras.dart';
import './providers/auth.dart';
import './providers/lista-convites.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new Lista(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => new ListaConvite(),
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
          AppRoutes.AUTH_HOME: (ctx) => AuthOrHomeScreen(),
          AppRoutes.HOME: (ctx) => HomePage(),
          AppRoutes.PERFIL: (ctx) => PerfilScreen(),
          AppRoutes.DADOS_PESSOAIS: (ctx) => DadosPessoaisScreen(),
          AppRoutes.ADICINAR_FAMILIA: (ctx) => AdicionarFailiaScreen(),
          AppRoutes.CONVITE_SCREEN: (ctx) => ConviteScreen(),
          AppRoutes.CALENDARIO_SCREEN: (ctx) => CalendarioScreen(),
          AppRoutes.LISTA_COMPRAS: (ctx) => ListaComprasScreen(),
          AppRoutes.LISTA_COMPRAS_FORM: (ctx) => ListFormScreen(),
        },
      ),
    );
  }
}
