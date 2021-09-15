import 'package:flutter/material.dart';
import 'package:practica2/src/screens/dashboard_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isLogin = false;
  //capturar texto de las cajas de texto
  TextEditingController txtEmailCon = TextEditingController(); //capturar texto
  TextEditingController txtPwdCon = TextEditingController(); //capturar texto

  @override
  Widget build(BuildContext context) {
    //se reconstruye lo que esta en el metodo build
    ElevatedButton btnLogin = ElevatedButton(
        style: ElevatedButton.styleFrom(primary: ColorSettings.colorButton),
        onPressed: () {
          print(txtEmailCon.text); //se obtiene el texto
          isLogin = true;
          setState(() {}); //se avisan los cambios
          Future.delayed(Duration(seconds: 5), () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DashBoardScreen())); // se cambia a otra pantalla
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [Icon(Icons.login), Text('Validar usuario')],
        ));

    TextFormField txtEmail = TextFormField(
      controller: txtEmailCon, //asignacion de controladores
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          hintStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          hintText: 'Introduce el email',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
    );

    TextFormField txtPwd = TextFormField(
      controller: txtPwdCon, //asignacion de controladores
      keyboardType: TextInputType.visiblePassword, //tipo de teclado a aparecer
      maxLength: 5, //limite de caracteres
      obscureText: true, //se oculta como si fuera contraseña
      decoration: InputDecoration(
          hintStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          hintText: 'Introduce el password',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5)),
    );

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/fondo.png'), fit: BoxFit.fill)),
        ),
        // LayoutBuilder(
        //     builder: (BuildContext context, BoxConstraints constraints) {
        //   return SingleChildScrollView(
        // child:
        Card(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 50),
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: ListView(
              shrinkWrap: true,
              children: [
                txtEmail,
                SizedBox(
                  height: 15,
                ),
                txtPwd,
                btnLogin
              ],
            ),
          ),
        ),
        // );
        // }),
        Positioned(
          child: Image.asset('assets/logo.png', width: 130),
          top: 100,
        ),
        Positioned(
          child: isLogin == true ? CircularProgressIndicator() : Container(),
          top: 335,
        )
      ],
    );
  }
}
