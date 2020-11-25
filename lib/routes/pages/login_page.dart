import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/socket_service.dart';
import 'package:chat_app/widgets/boton_azul.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/labels.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffF2F2F2),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Logo(
                    titulo: 'Messenger',
                  ),
                  _Form(),
                  Labels(
                    ruta: 'register',
                    cuenta: 'No tienes cuenta?',
                    ingresa: 'Crea una ahora',
                  ),
                  Text(
                    'Terminos y condiciones de uso',
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          Custominput(
            icon: Icons.mail_outline,
            placeHolder: 'correo',
            tipoTeclado: TextInputType.emailAddress,
            textController: emailController,
          ),
          Custominput(
            icon: Icons.lock_outline,
            placeHolder: 'password',
            textController: passController,
            isPassword: true,
          ),
          BotonAzul(
              texto: 'ingrese',
              onPressed: authService.autenticando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final loginOK = await authService.login(
                          emailController.text.trim(),
                          passController.text.trim());

                      if (loginOK) {
                        //TODO: navegar a la siguiente pantalla
                        socketService.connect();

                        Navigator.pushReplacementNamed(context, 'usuarios');
                      } else {
                        // mostrar alerta
                        mostrarAlerta(
                            context, 'Error', 'Credenciales incorrectas');
                      }
                    })
        ],
      ),
    );
  }
}
