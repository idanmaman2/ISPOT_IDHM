import 'dart:convert';

import 'package:http/http.dart';
import 'package:spotify/spotify.dart';
import 'package:test323232/Track.dart';

class spot {
  static Future<Response> getTracksByPlaylistId(
      String playlistId, SpotifyApi x) async {
    //https://api.spotify.com/v1/playlists/{playlist_id}/tracks
    //'v1/playlists/$playlistId/tracks'

    return (await x.client).get(Uri(
        scheme: "https",
        host: "api.spotify.com",
        path: "/v1/playlists/${playlistId}/tracks",
        queryParameters: {'limit': '100'}));
  }

  static SpotifyApi? _spotInstance;
  static late Set<TrackSpot> songs;

  static Future<SpotifyApi> getSpotInstance(
      {dynamic? grant, String url = ""}) async {
    if (_spotInstance == null) {
      songs = await getLastSongs(_spotInstance as SpotifyApi);
    }
    _spotInstance ??= SpotifyApi.fromAuthCodeGrant(grant, url);
    return _spotInstance as SpotifyApi;
  }

  static Future<Set<TrackSpot>> getLastSongs(SpotifyApi x) async {
    Set<TrackSpot> songsItems = {};

    var x1 = await (x).me.recentlyPlayed(limit: 50);
    var x2 = await x.playlists.me.all(); //
    var x3 = await x.tracks.me.saved.all(); //first name - playlist get
    var x4 = await (x).me.topTracks(); // first TrackSvaed -> track ->  name
    var x5 = await x.me.topArtists();
    print('\nFeatured Playlist:');
    var featuredPlaylists = await x.playlists.featured.all();

    for (var element in featuredPlaylists) {
      print("x21: " + element.name!);
      for (var element2 in await (jsonDecode(
          (await getTracksByPlaylistId(element.id!, x)).body)?['items'])) {
        print("playlist songggg ${element.name!} : " +
            (element2?['track']?['name'] ?? "no"));
        if (element2['track'] != null &&
            element2?['track']['name'] != null &&
            element2['track']['id'] != null &&
            element2?['track']?['href'] != null) {
          songsItems.add(TrackSpot(element2?['track']?['name'],
              element2?['track']?['id'], element2?['track']?['href']));
        }
      }
    }
    songsItems.addAll(
        x1.map((e) => TrackSpot.fromTrackSimple(e.track as TrackSimple)));

    print("x2: " + x2.first.name!);

    for (var element in x2) {
      print("x21: " + element.name!);
      for (var element2 in await (jsonDecode(
          (await getTracksByPlaylistId(element.id!, x)).body)?['items'])) {
        print("playlist songggg ${element.name!} : " +
            (element2?['track']?['name'] ?? "no"));

        songsItems.add(TrackSpot(element2?['track']?['name'],
            element2?['track']?['id'], element2?['track']?['href']));
      }
    }

    // (await (Playlists(x).getTracksByPlaylistId(element.id)).all())
    //  .forEach((element2) {
    // print(element2.name);
    //  });

    songsItems.addAll(x3.map((e) => TrackSpot.fromTrack(e.track as Track)));

    x4.forEach((element) {
      songsItems.addAll(
          element.album!.tracks!.map((e) => TrackSpot.fromTrackSimple(e)));
    });

    return songsItems;
  }
}
