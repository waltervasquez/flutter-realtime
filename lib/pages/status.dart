import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:band_name/services/socket_services.dart';

class StatusPage extends StatelessWidget{
   @override
  Widget build(BuildContext context) {
     final socketServices = Provider.of<SocketService>(context);
     return Scaffold(
       body: Column(
         mainAxisAlignment:  MainAxisAlignment.center,
         children: [
           Text('Heola ${ socketServices.serverStatus }')
         ],
       ),
       floatingActionButton:  FloatingActionButton(
         child: Icon( Icons.message ),
         onPressed: () {
           socketServices.socket.emit('emitir-mensaje', 'Enviando desde Flutter');
         },
       ),
     );
  }
}