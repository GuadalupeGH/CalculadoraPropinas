import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:practica2/src/models/perfil_model.dart';
import 'dart:io';
import '../database/database_helper_perfil.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  late DatabaseHelperPerfil _databaseHelperPerfil;
  PerfilModel? perfil;
  bool bandera1 = false;
  bool bandera2 = false;
  bool bandera3 = false;
  bool bandera4 = false;
  bool bandera5 = false;

  @override
  //implementa un metodo antes de que se muestre la interfaz
  void initState() {
    super.initState();
    _databaseHelperPerfil = DatabaseHelperPerfil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DASHBOARD'),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      drawer: Drawer(
        // se coloca un menu de hambuerguesa

        child: ListView(
          children: [
            FutureBuilder(
                future: _databaseHelperPerfil.getPerfil(1),
                builder: (_, AsyncSnapshot<PerfilModel> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Ocurrio un error en la petición'),
                    );
                  } else {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return _datos(snapshot.data!);
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }
                }),
            ListTile(
              title: Text('Propinas'),
              subtitle: Text('Descripción corta'),
              leading: Icon(Icons.monetization_on_outlined),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/opc1');
              },
            ),
            ListTile(
              title: Text('Intenciones'),
              subtitle: Text('Intenciones implícitas'),
              leading: Icon(Icons.phone_android),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/intenciones');
              },
            ),
            ListTile(
              title: Text('Notas'),
              subtitle: Text('CRUD notas'),
              leading: Icon(Icons.phone_android),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/notas');
              },
            ),
            ListTile(
              title: Text('Movies'),
              subtitle: Text('Prueba API REST'),
              leading: Icon(Icons.movie),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/movie');
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _datos(PerfilModel perfil) {
    return UserAccountsDrawerHeader(
        accountName: Text(
            perfil.nombre! + ' ' + perfil.aPaterno! + ' ' + perfil.aMaterno!),
        accountEmail: Text(perfil.email!),
        currentAccountPicture: ClipOval(
          child: (perfil.avatar == '')
              ? Image.network(
                  'https://image.flaticon.com/icons/png/512/1177/1177568.png',
                  fit: BoxFit.cover,
                )
              : Image.file(
                  File(perfil.avatar!),
                  fit: BoxFit.cover,
                ),
        ),
        decoration: BoxDecoration(color: ColorSettings.colorPrimary),
        otherAccountsPictures: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/perfil');
            },
            icon: Icon(Icons.edit),
            color: Colors.white,
          )
        ]);
  }
}
