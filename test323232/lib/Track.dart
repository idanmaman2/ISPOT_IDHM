import 'package:spotify/spotify.dart';

class TrackSpot {
  late String? name;
  late String? id;
  late String? uri;
  TrackSpot(String name, String id, String uri)
      : name = name,
        id = id,
        uri = uri;

  TrackSpot.fromTrack(Track x)
      : name = x.name,
        id = x.id,
        uri = x.uri;
  TrackSpot.fromTrackSimple(TrackSimple x)
      : name = x.name,
        id = x.id,
        uri = x.uri;

  TrackSpot.fromTackLink(TrackLink x)
      : id = x.id,
        uri = x.uri,
        name = "";
  void fromTrackLinkName(SpotifyApi y) async {
    name = await (await y.tracks.get(this.id as String)).name;
  }
}
