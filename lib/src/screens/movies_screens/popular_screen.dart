import 'package:flutter/material.dart';
import 'package:practica2/src/models/popular_movies_model.dart';
import 'package:practica2/src/network/api_popular.dart';
import 'package:practica2/src/views/card_popular.dart';

class PopularScreen extends StatefulWidget {
  PopularScreen({Key? key}) : super(key: key);

  @override
  _PopularScreenState createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apiPopular;
  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: apiPopular!.getAllPopular(),
          builder: (BuildContext context,
              AsyncSnapshot<List<PopularMoviesModel>?> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Hay un error en la petición'),
              );
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                return _listPopularMovies(snapshot.data);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }
          }),
    );
  }

  Widget _listPopularMovies(List<PopularMoviesModel>? movies) {
    return Container(
      color: Colors.black87,
      padding: EdgeInsets.all(20),
      child: ListView.separated(
          itemBuilder: (context, index) {
            PopularMoviesModel popular = movies![index];
            return CardPopularView(popular: popular);
          },
          separatorBuilder: (_, __) => Divider(height: 20),
          itemCount: movies!.length),
    );
  }
}
