import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practica2/src/models/popular_movies_model.dart';

class ApiPopular {
  var URL = Uri.parse(
      'https://api.themoviedb.org/3/movie/popular?api_key=2a17a7ca3acce331f0c340de5b3b88a5&language=es-MX&page=1');

  Future<List<PopularMoviesModel>?> getAllPopular() async {
    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      List<PopularMoviesModel> listaPopular =
          popular.map((movie) => PopularMoviesModel.fromMap(movie)).toList();
      return listaPopular;
    } else {
      return null;
    }
  }
}
