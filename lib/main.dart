import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
//import 'package:audioplayers/audio_cache.dart';
//import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}
//AudioCache cache = AudioCache();
//AudioPlayer player = AudioPlayer();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Hello World',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'RedHatDisplay',
      ),
      home: MyHomePage(),
    );

  }
}
final assetsAudioPlayer = AssetsAudioPlayer();
// ignore: must_be_immutable
class MyHomePage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: PageView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          view(
              imgUrl: 'https://images.pexels.com/photos/1616403/pexels-photo-1616403.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
              audUrl: 'assets/dueloffates.mp3',
              isNet: false,
              title: 'Duel Of The Fates',
              artist: 'John Williams'
          ),
          view(
              imgUrl: 'https://images.pexels.com/photos/2110951/pexels-photo-2110951.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
              audUrl: 'https://raw.githubusercontent.com/smc181002/media_files/master/imperialmarch.mp3',
              isNet: true,
              title: 'The Imperial March',
              artist: 'John Williams'
          ),
        ],
      ),
      backgroundColor: Color(0xFFFEFEFE),
    );
  }

  Widget view( {String imgUrl, String audUrl, bool isNet, String title, String artist} ) {
    String type;
    if (isNet){
      type = 'Network';
    } else {
      type = 'Assets';
    }
    print(imgUrl);
    return Container(
//    height: 720,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 110),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 60.0),
            alignment: Alignment.center,
            width: double.maxFinite,
            height: 270.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Color(0x36000000),
                    blurRadius: 32.0,
                    spreadRadius: 0,
                    offset: Offset(0, 16.0)
                ),
                BoxShadow(
                    color: Color(0x12000000),
                    blurRadius: 32.0,
                    spreadRadius: 0,
                    offset: Offset(0, 8.0)
                )
              ],
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imgUrl)),
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              color: Colors.blueAccent,
            ),
          ),
          SizedBox(height: 40),
          Text(
            title,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'By $artist',
            style: TextStyle(
                color: Color(0x99000000)
            ),
          ),
          SizedBox(height: 72),
          Text('This is audio form $type'),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                  icon: Icon(Icons.play_arrow),
                  iconSize: 36,
                  onPressed: () async {
                    if (isNet) {
                      await assetsAudioPlayer.open(Audio.network(audUrl));
                    } else {
                      await assetsAudioPlayer.open(Audio(audUrl));
                    }
                  }
              ),
              IconButton(
                icon: Icon(Icons.pause),
                iconSize: 36,
                onPressed: () => assetsAudioPlayer.playOrPause(),
//              onPressed: () => print(height.round()),
              ),
              IconButton(
                icon: Icon(Icons.stop),
                iconSize: 36,
                onPressed: () => assetsAudioPlayer.stop(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}