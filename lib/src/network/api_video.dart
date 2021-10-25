import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:practica2/src/models/video_model.dart';

class ApiVideo {
  var id;
  ApiVideo(this.id);
  Future<List<VideoModel>?> getAllVideo() async {
    var URL = Uri.parse('https://api.themoviedb.org/3/movie/' +
        id.toString() +
        '/videos?api_key=2a17a7ca3acce331f0c340de5b3b88a5&language=es-MX');

    final response = await http.get(URL);
    if (response.statusCode == 200) {
      var popular = jsonDecode(response.body)['results'] as List;
      List<VideoModel> listVideo =
          popular.map((movie) => VideoModel.fromMap(movie)).toList();
      return listVideo;
    } else {
      return null;
    }
  }
}
