import 'package:flutter/material.dart';

class Detail2Screen extends StatefulWidget {
  Detail2Screen({Key? key}) : super(key: key);

  @override
  _Detail2ScreenState createState() => _Detail2ScreenState();
}

class _Detail2ScreenState extends State<Detail2Screen> {
  @override
  Widget build(BuildContext context) {
    final movie =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 240,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  'https://image.tmdb.org/t/p/w500${movie['backdrop_path']}',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 180,
          child: Container(
            decoration: BoxDecoration(color: Colors.black),
          ),
        ),
        Center(
          child: Container(
            height: 450,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: Color.fromRGBO(23, 27, 22, 1),
            ),
            child: ListView(
              children: [
                Card(
                  
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
