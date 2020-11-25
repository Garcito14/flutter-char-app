import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/models/usuario.dart';
import 'package:chat_app/models/usuarios_response.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/services/auth_service.dart';

class UsuariosService {
  Future<List<Usuario>> getUsuarios() async {
    try {
      final resp = await http.get('${Enviroment.apiUrl}/usuarios/user',
          headers: {
            'Content-type': 'apllication/json',
            'x-token': await AuthService.getToken()
          });
      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
