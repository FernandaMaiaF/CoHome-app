import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './utils/app-routes.dart';

import 'screens/home-auth-screen.dart';
import './screens/homepage-screen.dart';
import 'screens/perfil-screen.dart';
import 'screens/dados-pessoais-form-screen.dart';
import 'screens/familia-form-screen.dart';
import './screens/calendario-screen.dart';
import './screens/lista-compras-screen.dart';
import 'screens/lista-compras-form-screen.dart';
import './screens/convites-screen.dart';
import 'screens/home-familia-screen.dart';
import './screens/membros-familia-screen.dart';
import './screens/convites-form-screen.dart';
import './screens/seguranca-form.dart';
import './screens/lista-tarefas-screen.dart';
import './screens/lista-tarefas-form-screen.dart';

import './providers/lista-compras.dart';
import './providers/auth.dart';
import './providers/lista-convites.dart';
import './providers/family-provider.dart';
import './providers/auth1.dart';
import './providers/familyInfo1.dart';
import './providers/userInfo1.dart';

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
        ChangeNotifierProvider(
          create: (_) => new ListaMembros(),
        ),
        ChangeNotifierProvider(
          create: (_) => new Auth1(),
        ),
        ChangeNotifierProvider(
          create: (_) => new UserInfo(),
        ),
        ChangeNotifierProvider(
          create: (_) => new FamilyInfo(),
        )
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
          AppRoutes.FAMILY_HOME: (ctx) => FamilyHomeScreen(),
          AppRoutes.PERFIL: (ctx) => PerfilScreen(),
          AppRoutes.DADOS_PESSOAIS: (ctx) => DadosPessoaisScreen(),
          AppRoutes.ADICINAR_FAMILIA: (ctx) => AdicionarFailiaScreen(),
          AppRoutes.CONVITE_SCREEN: (ctx) => ConviteScreen(),
          AppRoutes.FAMILY_MEMBROS: (ctx) => MembrosFamiliaScreen(),
          AppRoutes.CALENDARIO_SCREEN: (ctx) => CalendarioScreen(),
          AppRoutes.LISTA_COMPRAS: (ctx) => ListaComprasScreen(),
          AppRoutes.LISTA_COMPRAS_FORM: (ctx) => ListFormScreen(),
          AppRoutes.CONVITE_FORM: (ctx) => ConviteFormScreen(),
          AppRoutes.SEGURANCA_FORM: (ctx) => SegurancaFormScreen(),
          AppRoutes.LISTA_TAREFAS: (ctx) => ListaTarefasScreen(),
          AppRoutes.LISTA_TAREFAS_FORM: (ctx) => ListTarefasFormScreen(),
        },
      ),
    );
  }
}
