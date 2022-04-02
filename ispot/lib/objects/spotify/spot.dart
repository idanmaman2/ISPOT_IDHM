import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:ispot/exstnsions/set_exs/exstions.dart';
import 'package:ispot/exstnsions/sporify/exstions.dart';
import 'package:ispot/objects/spotify/track_object.dart';
import 'package:spotify/spotify.dart';

class spot {
  static SpotifyApi? _spotInstance ;
  static final List<TrackSpot> _songs = []   ;
  static int _indexer = -1 ; 

  static SpotifyApi getSpotInstance({dynamic? grant, String url = ""})  {
    _spotInstance ??= SpotifyApi.fromAuthCodeGrant(grant, url);
    return _spotInstance!;
  }
 
  static Future initSongs () async{
      _songs.removeWhere((element) => true); 
        _songs.addAll((await _getLastSongs()).shuffle());
  }

  static Future<Set<TrackSpot>> _getLastSongs({bool extra = false }) async {
    _indexer = -1 ;
    Set<TrackSpot> songsItems = {};
     DateTime dt = DateTime.now().subtract(Duration(hours: 1));
    var x1 = await getSpotInstance().me.recentlyPlayed(limit: 50, after: dt);
    var x2 = await getSpotInstance().playlists.me.all(); //
    var x3 = await getSpotInstance().tracks.me.saved.all(); //first name - playlist get
    var featuredPlaylists = await getSpotInstance().playlists.featured.all();

    for (var element in featuredPlaylists) {
    songsItems.addAll(  (await  getSpotInstance().getTracksByPlaylistId(element.id!) ).map((e) => TrackSpot.fromTrack(e)));
    }
    songsItems.addAll(x1.map((e) => TrackSpot.fromTrackSimple(e.track as TrackSimple)));
    for (var element in x2) {
      songsItems.addAll(  (await  getSpotInstance().getTracksByPlaylistId(element.id!) ).map((e) => TrackSpot.fromTrack(e)));
    }
    if(extra){
          var x4 = await getSpotInstance().me.topTracks(); // first TrackSvaed -> track ->  name
          var x5 = await getSpotInstance().me.topArtists();
          songsItems.addAll(x3.map((e) => TrackSpot.fromTrack(e.track as Track)));
          x4.forEach((element) {
            songsItems.addAll(
            element.album!.tracks!.map((e) => TrackSpot.fromTrackSimple(e)));
          });
    } 
    return songsItems;
  }

  static TrackSpot get  getNextSong => _songs[min(_songs.length, ++_indexer)];
 
  static TrackSpot get  getPrevSong => _songs[max(0, --_indexer)];
  
  static TrackSpot get getCurrentSong => _songs[min(max(0,_indexer),_songs.length)]; // in the first songs - current and next will return the same instead of throwing and error . 



}
