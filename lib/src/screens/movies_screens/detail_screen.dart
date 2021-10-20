import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //recuperacion del mapa
    final movie =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500${movie['posterpath']}'),
              fit: BoxFit.cover)),
    );
  }
}
