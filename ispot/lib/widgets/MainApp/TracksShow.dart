
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ispot/design/color.dart';
import 'package:ispot/widgets/MainApp/musicShower.dart';
import 'package:ispot/widgets/instgram/instagram_profile_show.dart';
import 'package:ispot/widgets/spotify/song_card.dart';
import 'package:spotify/spotify.dart';

class TracksShow extends StatelessWidget {
 final  Iterable<Track> tracks ; 
  const TracksShow(this.tracks , {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body : ListView(
        children:List.generate(tracks.length, (index) => 
        GestureDetector(onTap: (){
          Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => MusicShower(tracks.skip(index).first),
        ));

        } , child: songCard(tracks.skip(index).first ,index: index,bg : Colors.transparent, fg : (index %2 ==0 ? spotifyMain : spotifySecondry)))),
      
    
    
    
    
      ),
    );
  }
}