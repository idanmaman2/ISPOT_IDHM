import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:insta_dart/insta_dart.dart';
import 'package:ispot/exstnsions/sporify/exstions.dart';
import 'package:ispot/objects/spotify/spot.dart';
import 'package:ispot/widgets/MainApp/MusicChooser.dart';
import 'package:ispot/widgets/MainApp/home_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify/spotify.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../MainApp/musicShower.dart';
import '../../instgram/instagram_profile_show.dart';




class SpotifyLoginProvider extends ChangeNotifier {


  String ? _pathVar = null ;
  Future<String> get _path async{
    _pathVar ??= (await getApplicationDocumentsDirectory()).path + "/spotgrat.json";
    return _pathVar!;
  } 


  Future<SpotifyApi ? > getGrant()async {
try{
      File file = File(await _path);
      Map  json = jsonDecode(await file.readAsString()); 
      if(json.containsKey("grant") && json.containsKey("url")){
        String grantJ  =  json["grant"];
        String urlJ = json["url"];
      if(grantJ != null && urlJ != null){
        return  spot.getSpotInstance(grant:grantJ, url: urlJ);  
      }
   
            }
 
}
catch(e){
  //I dont care
}
    return null ;

  }



  Future LoadToken(dynamic grant, NavigationRequest navReq) async {
    final spotify = spot.getSpotInstance(grant: grant, url: navReq.url);
    try{
      Map json = Map (); 
      json["grant"]=grant ; 
      json["url"]=navReq.url; 
      File file = File(await _path);
      file.writeAsString(jsonEncode(json));
    }
    catch(e){
        //I dont care 
    }




  }

  void  nextScreen(context)  {
       Future.delayed(Duration(milliseconds: 10 )).then((_)async{
        SpotifyApi spotify = spot.getSpotInstance();
    Track trk = (await spotify.getTracksByPlaylistId((await spotify.playlists.me.first()).items!.last.id as String)).first;

Navigator.pop(context); //no back to that page
   Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => MusicChooser(spotify),
        ));

  
   }); 

    
    
  }



}



