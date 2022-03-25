import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';
import 'package:spotify/spotify.dart';
import 'package:test323232/Objects/track_object.dart';
import 'package:test323232/Tools_Static/exstions.dart';

class spot {


  static SpotifyApi? _spotInstance ;
  static final List<TrackSpot> _songs = []   ;
  static int _indexer = -1 ; 

  static Future<Response> _getTracksByPlaylistId(String playlistId, SpotifyApi x) async {
    //https://api.spotify.com/v1/playlists/{playlist_id}/tracks
    //'v1/playlists/$playlistId/tracks'

    return (await x.client).get(Uri(
        scheme: "https",
        host: "api.spotify.com",
        path: "/v1/playlists/$playlistId/tracks",
        queryParameters: {'limit': '100'}));
  }

  static SpotifyApi getSpotInstance({dynamic? grant, String url = ""})  {
    _spotInstance ??= SpotifyApi.fromAuthCodeGrant(grant, url);
    print("hello");
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
      print("x21: " + element.name!);
      for (var element2 in await (jsonDecode(
          (await _getTracksByPlaylistId(element.id!, getSpotInstance())).body)?['items'])) {
        print("playlist songggg ${element.name!} : " +
            (element2?['track']?['name'] ?? "no"));
        if (element2['track'] != null &&
            element2?['track']['name'] != null &&
            element2['track']['id'] != null &&
            element2?['track']?['href'] != null) {
              print(element2?['track']?["artists"]);
          songsItems.add(TrackSpot(element2?['track']?['name'],
              element2?['track']?['id'], element2?['track']?['href'],element2?['track']?["artists"]!.map((x)=> x["name"]).map<String>((x) => x.toString()).toList()));
        }
      }
    }
    songsItems.addAll(
        x1.map((e) => TrackSpot.fromTrackSimple(e.track as TrackSimple)));
    print("x2: " + x2.first.name!);

    for (var element in x2) {
      print("x21: " + element.name!);
      for (var element2 in await (jsonDecode(
          (await _getTracksByPlaylistId(element.id!, getSpotInstance())).body)?['items'])) {
        print("playlist songggg ${element.name!} : " +
            (element2?['track']?['name'] ?? "no"));

        songsItems.add(TrackSpot(element2?['track']?['name'],
            element2?['track']?['id'], element2?['track']?['href'],element2?['track']?["artists"]!.map((x)=> x["name"]).map<String>((x) => x.toString()).toList() ));
      }
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

  static TrackSpot getNextSong() => _songs[min(_songs.length, ++_indexer)];
 
  static TrackSpot getPrevSong() => _songs[max(0, --_indexer)];
  
  static TrackSpot getCurrentSong() => _songs[min(max(0,_indexer),_songs.length)]; // in the first songs - current and next will return the same instead of throwing and error . 



}
