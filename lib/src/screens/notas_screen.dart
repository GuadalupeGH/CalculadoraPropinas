import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:practica2/src/screens/agregar_nota_screen.dart';
import 'package:practica2/src/utils/color_settings.dart';

class NotasScreen extends StatefulWidget {
  NotasScreen({Key? key}) : super(key: key);

  @override
  _NotasScreenState createState() => _NotasScreenState();
}

class _NotasScreenState extends State<NotasScreen> {
  //late indica que posteriormente sera inicializado
  late DatabaseHelper _databaseHelper;

  @override
  //implementa un metodo antes de que se muestre la interfaz
  void initState() {
    super.initState();
    _databaseHelper = DatabaseHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSettings.colorPrimary,
        title: Text('Gestión de notas'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/agregar');
              },
              icon: Icon(Icons.note_add))
        ],
      ),
      body: FutureBuilder(
        future: _databaseHelper
            .getAllNotes(), //metodo que rucupera la informacion de la base de datos
        builder:
            (BuildContext context, AsyncSnapshot<List<NotasModel>> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Ocurrio un error en la petición'),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              return _listadoNotas(snapshot.data!);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }
        },
      ),
    );
  }

  Widget _listadoNotas(List<NotasModel> notas) {
    //cuando sea dinamicos los datos usar ListView.builder
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(Duration(seconds: 2), () {
          setState(() {});
        });
      },
      child: ListView.builder(
        itemBuilder: (BuildContext context, index) {
          NotasModel nota = notas[index];
          return Card(
              child: Column(
            children: [
              Text(
                nota.titulo!,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(nota.detalle!),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AgregarNotaScreen(
                                    nota: nota,
                                  )));
                    },
                    icon: Icon(Icons.edit),
                    iconSize: 18,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirmación'),
                              content: Text('¿Estas seguro del borrado?'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      _databaseHelper
                                          .delete(nota.id!)
                                          .then((noRows) {
                                        if (noRows > 0) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'El registro se ha eliminado')));
                                          setState(() {});
                                        }
                                      });
                                    },
                                    child: Text('Si')),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('No')),
                              ],
                            );
                          });
                    },
                    icon: Icon(Icons.delete),
                    iconSize: 18,
                  ),
                ],
              )
            ],
          ));
        },
        itemCount: notas.length,
      ),
    );
  }
}