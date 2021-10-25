import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practica2/src/models/actores_model.dart';

class ApiActor {
  var id;
  ApiActor(this.id);
  Future<List<ActorModel>?> getAllActor() async {
    var URL = Uri.parse('https://api.themoviedb.org/3/movie/' +
        id.toString() +
        '/credits?api_key=2a17a7ca3acce331f0c340de5b3b88a5&language=es-MX');

    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['cast'] as List;
      List<ActorModel> listaActor =
          popular.map((movie) => ActorModel.fromMap(movie)).toList();
      return listaActor;
    } else {
      return null;
    }
  }
}
