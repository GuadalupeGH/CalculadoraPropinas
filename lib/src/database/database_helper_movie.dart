import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica2/src/models/perfil_model.dart';
import 'package:practica2/src/models/popular_movies_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperPerfil {
//constante estatica
  static final _nombreBD = 'MOVIE';
  static final _versionDB = 1;
  static final _nombreTBL = 'tblMovie';

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
        "CREATE TABLE $_nombreTBL( backdropPath VARCHAR(100), id INTEGER, originalLanguage VARCHAR(50), originalTitle VARCHAR(100), overview TEXT, popularity REAL,posterPath VARCHAR(100),releaseDate VARCHAR(100),title VARCHAR(100), voteAverage REAL, voteCount INTEGER )");
  }

  Future<int> insert(Map<String, dynamic> row) async {
    var conexion = await database;

    //la conexion no debe de ser nula para que ejecute el insert
    return conexion!.insert(_nombreTBL, row);
    //registra el id del ultimo valor insertado
  }

  Future<int> delete(int id) async {
    var conexion = await database;
    return await conexion!.delete(_nombreTBL, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<PopularMoviesModel>> getAllMovies() async {
    var conexion = await database;
    var result = await conexion!.query(_nombreTBL);
    return result
        .map((notaMap) => PopularMoviesModel.fromMap(notaMap))
        .toList();
  }

  Future<PopularMoviesModel> getMovie(int id) async {
    var conexion = await database;
    var result =
        await conexion!.query(_nombreTBL, where: 'id=?', whereArgs: [id]);
    if (result.isNotEmpty) {
      return PopularMoviesModel.fromMap(result.first);
    } else {
      return PopularMoviesModel(
        backdropPath: '',
        id: null,
        originalLanguage: '',
        originalTitle: '',
        overview: '',
        popularity: null,
        posterPath: '',
        releaseDate: '',
        title: '',
        voteAverage: null,
        voteCount: null,
      );
    }
  }
}
