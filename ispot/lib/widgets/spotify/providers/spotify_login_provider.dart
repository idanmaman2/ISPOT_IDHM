import 'package:flutter/material.dart';
import 'package:ispot/objects/spotify/spot.dart';
class SpotifyLoginProvider extends ChangeNotifier {

  Future init(dynamic grant,String url)async{
    //navReq.url
    final spotify = spot.getSpotInstance(grant: grant ,url: url);
    print(spot.initSongs());
  }








} 