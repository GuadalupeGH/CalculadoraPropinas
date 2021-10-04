import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/database/database_helper_perfil.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class PerfilScreen extends StatefulWidget {
  PerfilScreen({Key? key}) : super(key: key);

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  //posteriormente sera inicializado

  late DatabaseHelperPerfil _databaseHelperPerfil;
  File? image;
  final picker = ImagePicker();

  Future selectImage(opcion) async {
    var picketFile;
    try {
      if (opcion == 1) {
        picketFile = await picker.pickImage(source: ImageSource.camera);
      } else {
        picketFile = await picker.pickImage(source: ImageSource.gallery);
      }
      setState(() {
        if (picketFile != null) {
          this.image = File(picketFile.path);
        } else {
          print('Error');
        }
      });
    } catch (e) {
      print('foto error');
    }
  }

  //implementar metodo antes de que se muestra la interfaz
  @override
  void initState() {
    super.initState();
    _databaseHelperPerfil = DatabaseHelperPerfil();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: ColorSettings.colorPrimary,
      //   title: Text('Perfil'),
      // ),
      body: ListView(
        padding: EdgeInsets.only(top: 45, left: 20, right: 20),
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 20, top: 5),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/dashboard');
              },
              icon: Icon(Icons.arrow_back_ios_new),
              color: Colors.grey,
            ),
          ),
          Center(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      //poner una sombra
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 20,
                            color: Colors.black26,
                            offset: Offset(0, 20))
                      ]),
                  child: ClipOval(
                    child: image == null
                        ? Image.network(
                            'https://image.flaticon.com/icons/png/512/1177/1177568.png',
                            width: 180,
                            height: 180,
                          )
                        : Image.file(
                            image!,
                            width: 180,
                            height: 180,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 15,
                  right: 0,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: ColorSettings.colorButton,
                    child: IconButton(
                      padding: EdgeInsets.all(5),
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Foto de perfil'),
                                actions: [
                                  Column(
                                    children: [
                                      Container(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: ColorSettings
                                                      .colorButton),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                selectImage(1);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Icon(Icons.camera_alt),
                                                  Text('Cámara')
                                                ],
                                              ))),
                                      Container(
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  primary: ColorSettings
                                                      .colorButton),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                selectImage(2);
                                              },
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Icon(Icons.image),
                                                  Text('Galería')
                                                ],
                                              ))),
                                    ],
                                  )
                                ],
                              );
                            });
                      },
                    ),
                  ),
                  // ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(25),
            child: Column(
              children: [
                Container(
                  height: 65,
                  margin: EdgeInsets.only(top: 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Nombre",
                      labelStyle:
                          TextStyle(fontSize: 18, color: Colors.black54),
                      border: OutlineInputBorder(),
                    ),
                    maxLength: 100,
                  ),
                ),
                Container(
                  height: 65,
                  margin: EdgeInsets.only(top: 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Apellido paterno",
                      labelStyle:
                          TextStyle(fontSize: 18, color: Colors.black54),
                      border: OutlineInputBorder(),
                    ),
                    maxLength: 100,
                  ),
                ),
                Container(
                  height: 65,
                  margin: EdgeInsets.only(top: 10),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Apellido materno",
                      labelStyle:
                          TextStyle(fontSize: 18, color: Colors.black54),
                      border: OutlineInputBorder(),
                    ),
                    maxLength: 100,
                  ),
                ),
                Container(
                  height: 65,
                  margin: EdgeInsets.only(top: 10),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: "Teléfono",
                      labelStyle:
                          TextStyle(fontSize: 18, color: Colors.black54),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.phone),
                    ),
                    maxLength: 15,
                  ),
                ),
                Container(
                  height: 65,
                  margin: EdgeInsets.only(top: 10),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        labelText: "Correo electronico",
                        labelStyle:
                            TextStyle(fontSize: 18, color: Colors.black54),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.email)),
                    maxLength: 100,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 45,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "Guardar",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: ColorSettings.colorButton,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
