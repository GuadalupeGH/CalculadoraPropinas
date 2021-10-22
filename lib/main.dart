import 'package:flutter/material.dart';
import 'package:practica2/src/screens/dashboard_screen.dart';
import 'package:practica2/src/screens/intenciones_screen.dart';
import 'package:practica2/src/screens/movies_screens/detail2_screen.dart';
import 'package:practica2/src/screens/movies_screens/detail_screen.dart';
import 'package:practica2/src/screens/movies_screens/popular_screen.dart';
import 'package:practica2/src/screens/notas_screen.dart';
import 'package:practica2/src/screens/opcion1_screen.dart';
import 'package:practica2/src/screens/perfil_screen.dart';
import 'package:practica2/src/screens/splash_screen.dart';
import 'package:practica2/src/screens/agregar_nota_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/opc1': (BuildContext context) => Opcion1Screen(),
        '/intenciones': (BuildContext context) => IntencionesScreen(),
        '/notas': (BuildContext context) => NotasScreen(),
        '/agregar': (BuildContext context) => AgregarNotaScreen(),
        '/perfil': (BuildContext context) => PerfilScreen(),
        '/dashboard': (BuildContext context) => DashBoardScreen(),
        '/movie': (BuildContext context) => PopularScreen(),
        '/detail': (BuildContext context) => DetailScreen(),
        '/detail2': (BuildContext context) => Detail2Screen()
      },
      debugShowCheckedModeBanner: false, //eliminar la etiqueta DEBUG
      home: SplashScreen(),
    );
  }
}
