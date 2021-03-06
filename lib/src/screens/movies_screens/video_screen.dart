import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoScreen extends StatefulWidget {
  final id;
  VideoScreen(this.id);

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'video' + widget.id.toString(),
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.5),
        child: Center(
          child: YoutubePlayer(
            controller: YoutubePlayerController(
              initialVideoId: widget.id,
              flags: YoutubePlayerFlags(
                autoPlay: true,
                mute: false,
              ),
            ),
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.amber,
            progressColors: ProgressBarColors(
              playedColor: Colors.amber,
              handleColor: Colors.amberAccent,
            ),
            onReady: () {},
          ),
        ),
      ),
    );
  }
}
