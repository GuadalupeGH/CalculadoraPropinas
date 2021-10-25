import 'package:flutter/material.dart';
import 'package:practica2/src/models/actores_model.dart';

class ActorDetallesScreen extends StatelessWidget {
  ActorModel actor;
  ActorDetallesScreen(this.actor);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
            margin: EdgeInsets.only(top: 20),
            height: 180,
            width: 180,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage((actor.profilePath.toString() != '')
                        ? 'https://www.themoviedb.org/t/p/w600_and_h900_bestv2' +
                            actor.profilePath.toString()
                        : 'http://assets.stickpng.com/images/585e4beacb11b227491c3399.png')))),
        Container(
          child: Text(actor.name!),
        ),
        Container(
          child: Text(actor.character!),
        ),
        Container(
          child: Text(actor.originalName!),
        ),
      ]),
    );
  }
}
