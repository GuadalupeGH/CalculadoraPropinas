import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practica2/src/database/database_helper_movie.dart';
import 'package:practica2/src/models/actores_model.dart';
import 'package:practica2/src/models/popular_movies_model.dart';
import 'package:practica2/src/network/api_actores.dart';
import 'package:practica2/src/network/api_video.dart';
import 'package:practica2/src/screens/movies_screens/actor_detalles_screen.dart';
import 'package:practica2/src/screens/movies_screens/video_screen.dart';

class Detail2Screen extends StatefulWidget {
  Detail2Screen({Key? key}) : super(key: key);

  @override
  _Detail2ScreenState createState() => _Detail2ScreenState();
}

class _Detail2ScreenState extends State<Detail2Screen> {
  ApiActor? apiActor;
  bool favorito = false;
  DatabaseHelperMovie? _databaseHelperMovie;
  PopularMoviesModel? popular;
  Future video(var id) async {
    ApiVideo(id).getAllVideo().then((value) {
      Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(seconds: 2),
            pageBuilder: (context, animation, secondaryAnimation) =>
                VideoScreen(value!.elementAt(0).key),
          ));
    });
  }

  Future actualizar() async {
    if (this.favorito == false) {
      _databaseHelperMovie!.getMovie(popular!.id!).then((value) {
        if (value.id == null) {
          _databaseHelperMovie!.insert(popular!.toMap()).then((value) {
            if (value > 0) {
              this.favorito = true;
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('La pelicula se agrego a favoritos')));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('La solicitud no se completo')));
            }
          });
        }
      });
    } else {
      _databaseHelperMovie!.delete(popular!.id!).then((value) {
        if (value > 0) {
          this.favorito = false;
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('La pelicula se removio de favoritos')));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('La solicitud no se completo')));
        }
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _databaseHelperMovie = DatabaseHelperMovie();
  }

  @override
  Widget build(BuildContext context) {
    final movie =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    popular = movie['popular'];
    apiActor = ApiActor(popular!.id);
    this.favorito = movie['favorito'];
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
          future: apiActor!.getAllActor(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ActorModel>?> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('Hay un error en la petición'),
              );
            } else {
              if (snapshot.connectionState == ConnectionState.done) {
                return detalles(snapshot.data!, popular!);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }
          }),
    );
    ;
  }

  Widget detalles(List<ActorModel> actores, PopularMoviesModel movie) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 230,
          child: Stack(
            children: [
              Hero(
                tag: movie.id.toString(),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        'https://image.tmdb.org/t/p/w500${movie.backdropPath}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 45,
                right: 0,
                child: Container(
                  child: ElevatedButton(
                    onPressed: () {
                      video(movie.id);
                    },
                    child: Hero(
                      tag: 'video' + movie.id.toString(),
                      child: Container(
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.playCircle,
                              color: Colors.black38,
                              size: 30,
                            ),
                            Text(
                              '  Ver video',
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                color: Colors.black38,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ubuntu',
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromRGBO(255, 255, 255, 0.7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 200,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(color: Colors.black),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    'Actores',
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white70,
                      fontSize: 20,
                      fontFamily: 'Ubuntu',
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    height: 127,
                    child: ListView.builder(
                      itemCount: actores.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        ActorModel actor = actores.elementAt(index);
                        return Container(
                          margin: EdgeInsets.only(right: 20),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    transitionDuration: Duration(seconds: 2),
                                    pageBuilder: (context, animation,
                                            secondaryAnimation) =>
                                        ActorDetallesScreen(actor),
                                  ));
                            },
                            child: Column(
                              children: [
                                Hero(
                                  tag: actor.id!,
                                  child: Container(
                                    height: 70,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage((actor.profilePath
                                                    .toString() !=
                                                '')
                                            ? 'https://www.themoviedb.org/t/p/w600_and_h900_bestv2' +
                                                actor.profilePath.toString()
                                            : 'http://assets.stickpng.com/images/585e4beacb11b227491c3399.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    actor.name!,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w500,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    actor.character!,
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white70,
                                      fontFamily: 'Ubuntu',
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
        Center(
          child: Container(
            height: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Color.fromRGBO(23, 27, 22, 1),
            ),
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Flexible(
                        flex: 8,
                        fit: FlexFit.tight,
                        child: Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            '${movie.title}',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 20,
                            right: 10,
                          ),
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(31, 33, 30, 1),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${movie.voteAverage}',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontFamily: 'Ubuntu',
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 3,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 20,
                          right: 10,
                        ),
                        width: 170,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(31, 33, 30, 1),
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                  left: 20,
                                  right: 10,
                                ),
                                child: Icon(Icons.date_range)),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${movie.releaseDate}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontFamily: 'UbuntuLight',
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        width: 100,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(31, 33, 30, 1),
                            borderRadius: BorderRadius.circular(30)),
                        alignment: Alignment.center,
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(
                                  left: 20,
                                  right: 10,
                                ),
                                child: Icon(Icons.translate)),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${movie.originalLanguage}'.toUpperCase(),
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontFamily: 'UbuntuLight',
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              actualizar();
                            });
                          },
                          child: FaIcon(
                            (this.favorito)
                                ? FontAwesomeIcons.solidHeart
                                : FontAwesomeIcons.heart,
                            color: (this.favorito) ? Colors.red : Colors.white,
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent, elevation: 0),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Flexible(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 20,
                          right: 20,
                        ),
                        height: 230,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              ),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    Flexible(
                      flex: 6,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 10,
                          right: 20,
                        ),
                        height: 230,
                        child: ListView(
                          children: [
                            Text(
                              '${movie.overview}',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white54,
                                fontFamily: 'UbuntuLight',
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.none,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
