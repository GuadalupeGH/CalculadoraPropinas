import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperPerfil {
//constante estatica
  static final _nombreBD = 'ESTUDIANTES';
  static final _versionDB = 1;
  static final _nombreTBL = 'tblPerfil';

  static Database? _database;
  //si esta creada la base de datos o no
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDataBase();
    return _database;
  }

  Future<Database> _initDataBase() async {
    //donde se guardara el archivo
    Directory carpeta = await getApplicationDocumentsDirectory();
    //ruta completa a la BD
    String rutaDB = join(carpeta.path, _nombreBD);
    return openDatabase(rutaDB, version: _versionDB, onCreate: _crearTabla);
  }

  //tabla que guarda los datos del perfil
  Future<void> _crearTabla(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $_nombreBD(id INTEGER PRIMARY KEY, avatar VARCHAR(100), nombre VARCHAR(100), aPaterno VARCHAR(100), aMaterno VARCHAR(100), telefono VARCHAR(15), email VARCHAR(100))");
  }

  Future<int> _inser(Map<String, dynamic> row) async {
    var conexion = await database;
    //la conexion no debe de ser nula para que ejecute el insert
    return conexion!.insert(_nombreTBL, row);
    //registra el id del ultimo valor insertado
  }

  Future<int> update(Map<String, dynamic> row) async {
    var conexion = await database;
    return conexion!
        .update(_nombreBD, row, where: 'id = ?', whereArgs: [row['id']]);
  }

  Future<NotasModel> getNote(int id) async {
    var conexion = await database;
    var result =
        await conexion!.query(_nombreTBL, where: 'id=?', whereArgs: [id]);
    return NotasModel.fromMap(result.first);
  }
}
