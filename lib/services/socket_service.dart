import 'package:chat_app/global/enviroment.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket _socket;
  ServerStatus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;
  Function get emit => this._socket.emit;

  void connect() async {
    final token = await AuthService.getToken();
    this._socket = IO.io(Enviroment.socketUrl, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token}
    });
    this._socket.on('connect', (_) {
      /* socket.emit('msg', 'test'); */
      this._serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    // socket.on('event', (data) => print(data));
    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStatus.Offline;
      notifyListeners();
    });
/*     socket.on('nuevo-mensaje', (payload) {
      print('nuevo-mensaje:');
      print('nombre: ' + payload['nombre']);
      print('mensaje: ' + payload['mensaje']);
      //print('mensaje: ' + payload['mensaje2']);
      print(payload.containsKey('mensaje2') ? payload['mensaje2'] : 'no hay');
    }); */
    // socket.on('fromServer', (_) => print(_));
  }

  void disconnect() {
    this._socket.disconnect();
  }
}
