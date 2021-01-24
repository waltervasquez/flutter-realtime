import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:band_name/models/band.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageSate createState() => _HomePageSate();
}

class _HomePageSate extends State<HomePage>{

  List<Band> bands = [
    Band(id : '1', name: 'Walter Vasquez', votes: 2),
    Band(id : '2', name: 'Mariling Florez', votes: 4),
    Band(id : '3', name: 'Veronica del carmen', votes: 6),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BandNames', style: TextStyle(color: Colors.black87),),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
            itemCount: bands.length,
            itemBuilder: (BuildContext context, int index) =>  _bandTitle(bands[index])
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBar
      ),
    );
  }

  Widget _bandTitle(Band band) {
    return Dismissible(
      key : Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direccion $direction');
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
          onTap: () => print(band.name),
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
    if(name.length > 0){
        this.bands.add(new Band(id : DateTime.now().toString(), name: name, votes: 0));
        setState(() {});
    }
    Navigator.pop(context);
  }
}