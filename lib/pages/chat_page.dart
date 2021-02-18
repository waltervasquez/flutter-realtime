import 'dart:io';

import 'package:band_name/widgets/chat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin{

  final _textController = new TextEditingController();
  final _focusNode = new FocusNode();
  bool _estaEscribiendo = false;
  List<ChatMessage> _messagesChat = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child:  Column(
            children: [
              CircleAvatar(
                child: Text('Test', style: TextStyle(fontSize: 12),),
                backgroundColor: Colors.blueAccent,
                maxRadius: 12,
              ),
              SizedBox(height: 3,),
              Text("AWalter Vasquez",style: TextStyle(color: Colors.black87, fontSize: 12),)
            ],
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: _messagesChat.length,
                itemBuilder: (_,i) => _messagesChat[i],
                reverse: true,
              ),
            ),
            Divider(height: 1,),
            Container(
              color: Colors.white,
              height: 50,
              child: _inputChat(),
            )
          ],
        ),
      ),
    );
  }
  Widget _inputChat() {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: [
            Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handlerSubmit,
                  onChanged: (String texto){
                    setState(() {
                      if(texto.trim().length > 0)
                        _estaEscribiendo = true;
                      else
                        _estaEscribiendo = false;
                    });
                  },
                  decoration: InputDecoration.collapsed(hintText: 'Enviar mensajes'),
                  focusNode: _focusNode,
                ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child:  Platform.isIOS ?
              CupertinoButton(
                  child: Text('Enviar'),
                  onPressed: _estaEscribiendo ? () => _handlerSubmit(_textController.text) : null ,
              ) : Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                child: IconTheme(
                  data: IconThemeData(color: Colors.blue[400]),
                  child: IconButton(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    icon: Icon(Icons.send, color: Colors.blue[400],),
                    onPressed: _estaEscribiendo ? () => _handlerSubmit(_textController.text) : null ,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _handlerSubmit(String texto){
    if(texto.length == 0) return;

    _textController.clear();
      _focusNode.requestFocus();
      final menssage = new ChatMessage( uid: '123', texto: texto, animationController: AnimationController(vsync: this, duration: Duration(milliseconds: 400)), );
      _messagesChat.insert(0, menssage);
      menssage.animationController.forward();
      setState(() {
        _estaEscribiendo = false;
      });
  }

   @override
  void dispose() {
    // TODO: implement dispose
     for(ChatMessage mesane in _messagesChat){
       mesane.animationController.dispose();
     }
    super.dispose();
  }
}




