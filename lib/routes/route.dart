import 'package:band_name/pages/chat_page.dart';
import 'package:band_name/pages/loading_page.dart';
import 'package:band_name/pages/login_page.dart';
import 'package:band_name/pages/register_page.dart';
import 'package:band_name/pages/usuarios_page.dart';
import 'package:flutter/cupertino.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuario' : ( _ ) => UsuariosPage(),
  'chat' : ( _ ) => ChatPage(),
  'login' : ( _ ) => LoginPage(),
  'register' : ( _ ) => RegistroPage(),
  'loading' :  ( _ ) => LoadingPage(),
};