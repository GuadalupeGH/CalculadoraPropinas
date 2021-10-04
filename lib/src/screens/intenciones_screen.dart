import 'package:flutter/material.dart';
import 'package:practica2/src/utils/color_settings.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class IntencionesScreen extends StatefulWidget {
  IntencionesScreen({Key? key}) : super(key: key);

  @override
  _IntencionesScreenState createState() => _IntencionesScreenState();
}

class _IntencionesScreenState extends State<IntencionesScreen> {
  File? image;

  Future tomarFoto() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    final imageTemporary = File(image.path);
    setState(() {
      this.image = imageTemporary;
    });

    print(image.path);
  }

  @override
  Widget build(BuildContext context) {
    // var image;
    // final picker = ImagePicker();

    return Scaffold(
      appBar: AppBar(
        title: Text('Intenciones Implicitas'),
        backgroundColor: ColorSettings.colorPrimary,
      ),
      body: ListView(
        children: [
          Card(
            elevation: 8.0,
            child: ListTile(
                tileColor: Colors.white54,
                title: Text('Abrir página web'),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.touch_app_rounded,
                      size: 18.0,
                      color: Colors.red,
                    ),
                    Text('https://celaya.tecnm.mx/')
                  ],
                ),
                leading: Container(
                  height: 40.0,
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.language,
                    color: Colors.black,
                  ),
                  decoration: BoxDecoration(
                      border: Border(right: BorderSide(width: 1.0))),
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: _abrirWeb),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white54,
              title: Text('Llamada Telefónica'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  Text('Cel: 4614218438')
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.phone_android,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _llamdaTelefonica,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white54,
              title: Text('Enviar SMS'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  Text('Cel: 4614218438')
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.sms_sharp,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarSMS,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white54,
              title: Text('Enviar Email'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  Text('To: 17030689@itcelaya.edu.mx')
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.email_outlined,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: _enviarEmail,
            ),
          ),
          Card(
            elevation: 8.0,
            child: ListTile(
              tileColor: Colors.white54,
              title: Text('Tomar Foto'),
              subtitle: Row(
                children: [
                  Icon(
                    Icons.touch_app_rounded,
                    size: 18.0,
                    color: Colors.red,
                  ),
                  Text('Sonrie :)')
                ],
              ),
              leading: Container(
                height: 40.0,
                padding: EdgeInsets.only(right: 10.0),
                child: Icon(
                  Icons.camera_alt_outlined,
                  color: Colors.black,
                ),
                decoration: BoxDecoration(
                    border: Border(right: BorderSide(width: 1.0))),
              ),
              trailing: Icon(Icons.chevron_right),
              onTap: tomarFoto,
            ),
          ),
          image != null
              ? Image.file(
                  image!,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                )
              : Icon(Icons.face),
        ],
      ),
    );
  }

  _abrirWeb() async {
    const url = "https://celaya.tecnm.mx/";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _llamdaTelefonica() async {
    const url = "tel: 4614218438";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _enviarSMS() async {
    const url = "sms:4614218438";
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  _enviarEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: '17031116@itcelaya.edu.mx',
      query: 'subject=',
    );

    var email = params.toString();
    if (await canLaunch(email)) {
      await launch(email);
    }
  }
}
