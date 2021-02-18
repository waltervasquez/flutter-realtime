import 'package:band_name/models/usuario.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  @override
  __UsuariosPageState createState() => __UsuariosPageState();
}


class __UsuariosPageState extends State<UsuariosPage> {

  RefreshController _refreshController = RefreshController(initialRefresh:  false);

  final usuarios =  [
    Usuario(uid: '1', nombre: 'juan', email: 'test1@test.com', online: true),
    Usuario(uid: '1', nombre: 'juan', email: 'test1@test.com', online: true),
    Usuario(uid: '1', nombre: 'juan', email: 'test1@test.com', online: true),
    Usuario(uid: '1', nombre: 'juan', email: 'test1@test.com', online: true),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mi Nombre", style: TextStyle(color: Colors.black87),),
        elevation: 1,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.exit_to_app, color: Colors.black87, ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: Icon(Icons.check_circle, color: Colors.blue,),
          )
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        onRefresh: _cargarUsuarios,
        header: WaterDropHeader(
          complete : Icon(Icons.check, color : Colors.blue[400]),
          waterDropColor: Colors.blue[400],
        ),
        child: _ListViewUsuarios(),
      ),
    );
  }

  ListView _ListViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
        itemBuilder: ( _ , i) => usuarioListTile(usuarios[i]),
        separatorBuilder: (_,i) => Divider(),
        itemCount: usuarios.length
    );
  }

  ListTile usuarioListTile(Usuario usuario) {
    return ListTile(
          title: Text(usuario.nombre),
          subtitle: Text(usuario.email),
          leading: CircleAvatar(
            child: Text(usuario.nombre.substring(0,3)),
          ),
          trailing: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: usuario.online ? Colors.green : Colors.red,
              borderRadius: BorderRadius.circular(100)
            ),
          ),
        );
  }

  _cargarUsuarios () async {
    await Future.delayed(Duration(microseconds: 1000));
    _refreshController.refreshCompleted();
  }
}
