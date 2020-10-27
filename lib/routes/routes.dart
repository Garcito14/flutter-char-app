import 'package:chat_app/routes/pages/chat_page.dart';
import 'package:chat_app/routes/pages/loading_page.dart';
import 'package:chat_app/routes/pages/login_page.dart';
import 'package:chat_app/routes/pages/register_page.dart';
import 'package:chat_app/routes/pages/usuarios_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  'usuarios': (_) => UsuariosPage(),
  'chat': (_) => ChatPage(),
  'login': (_) => LoginPage(),
  'register': (_) => RegisterPage(),
  'loading': (_) => LoadingPage(),
};
