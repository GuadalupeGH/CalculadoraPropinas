import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //recuperacion del mapa
    final movie =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 450,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500${movie['posterpath']}'),
                  fit: BoxFit.fill),
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            color: Colors.black,
            height: 600,
            margin: const EdgeInsets.only(top: 350),
          ),
          Container(
            margin: const EdgeInsets.only(top: 370),
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Text(
              '${movie['title']}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 25,
              ),
              textAlign: TextAlign.center,
            ),
            alignment: Alignment.topCenter,
          ),
          Container(
            margin: const EdgeInsets.only(top: 440),
            padding: EdgeInsets.only(left: 20),
            child: Text(
              'Descripción',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
              textAlign: TextAlign.left,
            ),
            alignment: Alignment.topLeft,
          ),
          Container(
            margin: const EdgeInsets.only(top: 460),
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 15,
            ),
            child: Text(
              '${movie['overview']}',
              style: TextStyle(
                color: Colors.white54,
                fontSize: 18,
              ),
              textAlign: TextAlign.justify,
            ),
            alignment: Alignment.topCenter,
          ),
        ],
      ),
    );

    // Scaffold(
    //   body: Center(
    //     child: AvatarGlow(
    //       child: Icon(
    //         Icons.favorite,
    //         size: 50,
    //         color: Colors.red,
    //       ),
    //       endRadius: 100,
    //       glowColor: Colors.red,
    //       duration: Duration(milliseconds: 2000),
    //       repeatPauseDuration: Duration(milliseconds: 100),
    //     ),
    //   ),
    // );
    // Stack(
    //   children: [
    // Container(
    //   decoration: BoxDecoration(
    //       image: DecorationImage(
    //           image: NetworkImage(
    //               'https://image.tmdb.org/t/p/w500${movie['posterpath']}'),
    //           fit: BoxFit.cover)),
    //      ),
    //   ],
    // );
  }
}
