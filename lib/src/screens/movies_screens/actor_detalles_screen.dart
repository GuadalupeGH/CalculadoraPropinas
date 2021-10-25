import 'package:flutter/material.dart';
import 'package:practica2/src/models/actores_model.dart';

class ActorDetallesScreen extends StatelessWidget {
  ActorModel actor;
  ActorDetallesScreen(this.actor);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Hero(
          tag: actor.id!,
          child: Container(
            margin: EdgeInsets.only(top: 100),
            height: 300,
            width: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage((actor.profilePath.toString() != '')
                    ? 'https://www.themoviedb.org/t/p/w600_and_h900_bestv2' +
                        actor.profilePath.toString()
                    : 'http://assets.stickpng.com/images/585e4beacb11b227491c3399.png'),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50),
          child: Text(
            actor.name!,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Text(
            actor.character!,
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
        ),
      ]),
    );
  }
}
