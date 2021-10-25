import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper_movie.dart';
import 'package:practica2/src/models/popular_movies_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:practica2/src/views/card_favorito_view.dart';
import 'package:practica2/src/views/card_popular.dart';

class FavoritosScreen extends StatefulWidget {
  FavoritosScreen({Key? key}) : super(key: key);

  @override
  _FavoritosScreenState createState() => _FavoritosScreenState();
}

class _FavoritosScreenState extends State<FavoritosScreen> {
  ApiPopular? apiPopular;
  late DatabaseHelperMovie _databaseHelperMovie;
  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
    _databaseHelperMovie = DatabaseHelperMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: _databaseHelperMovie.getAllMovies(),
          builder: (BuildContext context,
              AsyncSnapshot<List<PopularMoviesModel>?> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Hay un error en la petición'),
              );
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                return _listFavoritasMovies(snapshot.data);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }
          }),
    );
  }

  Widget _listFavoritasMovies(List<PopularMoviesModel>? movies) {
    return Container(
      color: Colors.black87,
      padding: EdgeInsets.all(20),
      child: ListView.separated(
          itemBuilder: (context, index) {
            PopularMoviesModel popular = movies![index];
            return CardFavoritoView(popular: popular);
          },
          separatorBuilder: (_, __) => Divider(height: 20),
          itemCount: movies!.length),
    );
  }
}
