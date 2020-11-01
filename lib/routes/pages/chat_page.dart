import 'dart:io';

import 'package:chat_app/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = new TextEditingController();
  final _focusNode = FocusNode();
  List<ChatMessage> _messages = [];
/*     ChatMessage(
      uid: '1223',
      texto:
          'hola mundoasdasdasdkajsdha jdkljsalkdjsakldjask ldjaklsjdasljdklasjdlkasdj ',
    ),
    ChatMessage(
      uid: '1223',
      texto: 'hola mundo ',
    ),
    ChatMessage(
      uid: '123',
      texto: 'hola mundo ',
    ),
    ChatMessage(
      uid: '123',
      texto: 'hola mundo ',
    ) */

  bool _estaEscribiendo = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Column(
            children: [
              CircleAvatar(
                child: Text(
                  'Te',
                  style: TextStyle(fontSize: 12),
                ),
                maxRadius: 12,
                backgroundColor: Colors.blueAccent,
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                'Test1',
                style: TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: _messages.length,
                  itemBuilder: (_, i) => _messages[i],
                  reverse: true,
                ),
              ),
              Divider(
                color: Colors.blue,
                height: 1,
              ),
              Container(
                color: Colors.white,
                child: _inputChat(),
              )
            ],
          ),
        ));
  }

  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
              child: (TextField(
                controller: _textController,
                onSubmitted: _handleSubmit,
                onChanged: (String texto) {
                  setState(() {
                    if (texto.trim().length > 0) {
                      _estaEscribiendo = true;
                    } else {
                      _estaEscribiendo = false;
                    }
                  });
                },
                decoration:
                    InputDecoration.collapsed(hintText: 'Enviar Mensaje'),
                focusNode: _focusNode,
              )),
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 4),
                child: Platform.isIOS
                    ? CupertinoButton(
                        child: Text('Enviar'),
                        onPressed: () {},
                      )
                    : Container(
                        margin: EdgeInsets.symmetric(horizontal: 4),
                        child: IconButton(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          icon: Icon(
                            Icons.send,
                            color: Colors.blue,
                          ),
                          onPressed: _estaEscribiendo
                              ? () => _handleSubmit(_textController.text.trim())
                              : null,
                        ),
                      ))
          ],
        ),
      ),
    );
  }

  _handleSubmit(String texto) {
    if (texto.length == 0) return;
    print(texto);
    _textController.clear();
    _focusNode.requestFocus();
    final newMessage = new ChatMessage(
      uid: '123',
      texto: texto,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 400)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {});
  }

  @override
  void dispose() {
    //TODO: off del socket
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }
}
