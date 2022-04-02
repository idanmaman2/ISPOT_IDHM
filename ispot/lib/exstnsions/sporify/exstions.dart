import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:spotify/spotify.dart';

extension PlayList on SpotifyApi {

  Future<Iterable<Track>> getTracksByPlaylistId(String playlistId) async{
   List<Track> result = [] ; 
   Response rsp =await  (await client).get(Uri(
        scheme: "https",
        host: "api.spotify.com",
        path: "/v1/playlists/$playlistId/tracks",
        queryParameters: {'limit': '100'}));
    Map<String,dynamic> bodyJson = jsonDecode(rsp.body); 
    Iterable items = bodyJson['items'];
    for(var element in items){
        if(element['track'] != null){
            result.add(Track.fromJson(element['track']));
        }
    }
    return result ; 

  


  }

}