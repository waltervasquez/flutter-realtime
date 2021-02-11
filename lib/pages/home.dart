
import 'dart:io';
import 'package:band_name/services/socket_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_name/models/band.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageSate createState() => _HomePageSate();
}

class _HomePageSate extends State<HomePage>{
  List<Band> bands = [];

  @override void initState() {
    final socketServices = Provider.of<SocketService>(context, listen: false);

    socketServices.socket.on('active-bands', _handleActiveBands);
    super.initState();
  }

  _handleActiveBands( dynamic payload) {
    this.bands = ( payload as List).map((e) => Band.fromMap(e)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final socketServices = Provider.of<SocketService>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
            child:  socketServices.serverStatus == ServerStatus.Online ?  Icon(Icons.check_circle, color: Colors.blue[300],) : Icon(Icons.offline_bolt, color: Colors.red[300],) ,
          ),
        ],
      ),
      body: Column(
        children: [
          _showGrafica(),
          Expanded(
              child: ListView.builder(
                  itemCount: bands.length,
                  itemBuilder: (BuildContext context, int index) =>  _bandTitle(bands[index])
              ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBar
      ),
    );
  }

  Widget _bandTitle(Band band) {
    final socketServices = Provider.of<SocketService>(context, listen: false);
    return Dismissible(
      key : Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        socketServices.socket.emit('delete-band', { 'id' : band.id });
      },
      background: Container(
        padding: EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text('Eliminar'),
        ),
      ),
      child : ListTile(
          leading: CircleAvatar(
            child: Text(band.name.substring(0,2)),
            backgroundColor: Colors.blue[100],
          ),
          title: Text(band.name),
          trailing: Text('${band.votes}', style: TextStyle(fontSize: 20),),
          onTap: () {
            socketServices.socket.emit('vote-band', { 'id' : band.id });
          },
        ),
    );
  }

  addNewBar() {
    final textController = new TextEditingController();

    if (Platform.isAndroid){
      showDialog(context: context,
          builder: (context) {
            return AlertDialog(
              title : Text('New Band Name'),
              content: TextField(
                controller: textController,
              ),
              actions: <Widget>[
                MaterialButton(
                    child: Text('ga'),
                    elevation: 5,
                    textColor: Colors.blue,
                    onPressed:  () => addBandToList(textController.text)
                )
              ],
            );
          });
    }else{
      showCupertinoDialog(context: context,
          builder: (context) {
              return CupertinoAlertDialog(
                title: Text('Band New Name'),
                content: CupertinoTextField(
                  controller: textController,
                ),
                actions: [
                  CupertinoDialogAction(
                      isDefaultAction: true,
                      child: Text('Add'),
                    onPressed: () => addBandToList(textController.text),
                  ),
                  CupertinoDialogAction(
                      isDestructiveAction: true,
                      child: Text('dismiss'),
                      onPressed: () => Navigator.pop(context),
                  ),
                ],
              );
          }
      );
    }
  }

  void addBandToList(String name){
    final socketServices = Provider.of<SocketService>(context, listen: false);
    if(name.length > 0){
        socketServices.socket.emit('crear-band', { 'name' : name });
    }
    Navigator.pop(context);
  }

  Widget _showGrafica(){
    Map<String, double> dataMap = new Map();
    bands.forEach((band) { dataMap.putIfAbsent(band.name, () => band.votes.toDouble()); });
    return Container(
      width: double.infinity,
      height : 200,
      child: PieChart(dataMap: dataMap,),
    );
  }
}