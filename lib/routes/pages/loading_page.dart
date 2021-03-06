import 'package:chat_app/routes/pages/login_page.dart';
import 'package:chat_app/routes/pages/usuarios_page.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final socketService = Provider.of<SocketService>(context, listen: false);
    final auteticando = await authService.isLoggedIn();
    if (auteticando) {
      //conectar al server
      socketService.connect();
      //   Navigator.pushReplacementNamed(context, 'usuarios');

      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (
                _,
                __,
                ___,
              ) =>
                  UsuariosPage(),
              transitionDuration: Duration(milliseconds: 0)));
    } else {
      //Navigator.pushReplacementNamed(context, 'login');
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (
                _,
                __,
                ___,
              ) =>
                  LoginPage(),
              transitionDuration: Duration(milliseconds: 0)));
    }
  }
}
