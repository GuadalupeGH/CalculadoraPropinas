import 'package:flutter/material.dart';
import 'package:practica2/src/models/popular_movies_model.dart';

class CardFavoritoView extends StatelessWidget {
  const CardFavoritoView({Key? key, required this.popular}) : super(key: key);
  final PopularMoviesModel popular;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(10.0), boxShadow: [
        BoxShadow(
            color: Colors.black87,
            offset: Offset(0.0, 5.0),
            blurRadius: 4,
            spreadRadius: 1)
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Hero(
              tag: popular.id!.toString(),
              child: Container(
                child: FadeInImage(
                  placeholder: AssetImage('assets/activity_indicator.gif'),
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500${popular.backdropPath}'),
                  fadeInDuration: Duration(milliseconds: 200),
                ),
              ),
            ),
            Opacity(
              opacity: 0.5,
              child: Container(
                padding: EdgeInsets.only(right: 20),
                height: 60,
                color: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        popular.title!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 35,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
