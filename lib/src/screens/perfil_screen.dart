import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/perfil_model.dart';
import '../database/database_helper_perfil.dart';

class PerfilScreen extends StatefulWidget {
  PerfilScreen({Key? key}) : super(key: key);

  @override
  _PerfilScreenState createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  //posteriormente sera inicializado
  TextEditingController _controllerNombre = TextEditingController();
  TextEditingController _controllerPaterno = TextEditingController();
  TextEditingController _controllerMaterno = TextEditingController();
  TextEditingController _controllerTelefono = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();

  late DatabaseHelperPerfil _databaseHelperPerfil;
  File? image;
  final picker = ImagePicker();
  PerfilModel? perfil;

  bool bandera1 = false;
  bool bandera2 = false;
  bool bandera3 = false;
  bool bandera4 = false;
  bool bandera5 = false;
  bool banderaEntero = false;
  Future obtenerInformacion() async {
    this._databaseHelperPerfil = DatabaseHelperPerfil();
    try {
      await this._databaseHelperPerfil.getPerfil(1).then((PerfilModel perfil) {
        if (perfil.id != null) {
          setState(() {
            this.perfil = perfil;
            this.image = File(this.perfil!.avatar!);
            print(this.image);
            _controllerNombre.text = this.perfil!.nombre!;
            _controllerPaterno.text = this.perfil!.aPaterno!;
            _controllerMaterno.text = this.perfil!.aMaterno!;
            _controllerTelefono.text = this.perfil!.telefono!;
            _controllerEmail.text = this.perfil!.email!;
          });
        } else {
          this.perfil = null;
        }
      });
    } catch (Exception) {
      print(Exception);
    }
  }

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

  guardar() {
    var nombre, paterno, materno, telefono, email, avatar;
    try {
      if (image != null) {
        avatar = image?.path;
      } else {
        avatar = '';
      }
      nombre = _controllerNombre.text;
      paterno = _controllerPaterno.text;
      materno = _controllerMaterno.text;
      telefono = _controllerTelefono.text;
      email = _controllerEmail.text;

      PerfilModel info = PerfilModel(
          id: 1,
          avatar: avatar,
          nombre: nombre,
          aMaterno: materno,
          aPaterno: paterno,
          telefono: telefono,
          email: email);
      if (perfil == null) {
        _databaseHelperPerfil.insert(info.toMap()).then((result) {
          if (result > 0) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('La información se guardo correctamente')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('La solicitud no se completo')));
          }
        });
      } else {
        _databaseHelperPerfil.update(info.toMap()).then((result) {
          if (result > 0) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('La información se actualizo correctamente')));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('La solicitud no se completo')));
          }
        });
      }
      this.banderaEntero = false;
      this.bandera1 = false;
      this.bandera2 = false;
      this.bandera3 = false;
      this.bandera4 = false;
      this.bandera5 = false;
    } catch (Exception) {
      print("Error");
    }
  }

  //implementar metodo antes de que se muestra la interfaz
  @override
  void initState() {
    _databaseHelperPerfil = DatabaseHelperPerfil();
    this.obtenerInformacion();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: (image == null || image!.path == '')
                        ? Image.network(
                            'https://image.flaticon.com/icons/png/512/1177/1177568.png',
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            image!,
                            width: 180,
                            height: 180,
                            fit: BoxFit.cover,
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
                    controller: _controllerNombre,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      errorText: bandera1 ? 'Campo obligatorio' : null,
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
                    controller: _controllerPaterno,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      errorText: bandera2 ? 'Campo obligatorio' : null,
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
                    controller: _controllerMaterno,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      errorText: bandera3 ? 'Campo obligatorio' : null,
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
                    controller: _controllerTelefono,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      errorText: (bandera4)
                          ? 'Campo obligatorio'
                          : (banderaEntero ? 'Numero invalido' : null),
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
                    controller: _controllerEmail,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        errorText: bandera5 ? 'Campo obligatorio' : null,
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
                    onPressed: () {
                      setState(() {
                        if (_controllerNombre.text.isEmpty) {
                          bandera1 = true;
                        } else {
                          if (_controllerPaterno.text.isEmpty) {
                            bandera2 = true;
                          } else {
                            if (_controllerMaterno.text.isEmpty) {
                              bandera3 = true;
                            } else {
                              if (_controllerTelefono.text.isEmpty) {
                                bandera4 = true;
                              } else {
                                if (_controllerEmail.text.isEmpty) {
                                  bandera5 = true;
                                } else {
                                  try {
                                    int.parse(_controllerTelefono.text);
                                    guardar();
                                  } catch (Exception) {
                                    banderaEntero = true;
                                  }
                                }
                              }
                            }
                          }
                        }
                      });
                    },
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
