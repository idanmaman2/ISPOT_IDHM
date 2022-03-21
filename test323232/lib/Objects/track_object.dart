import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/spotify.dart';
import 'package:test323232/Tools_Static/youtube_object.dart';
class TrackSpot {
  late String? name;
  late String? id;
  late String? uri;
  late String? originalPlayList;
  AudioPlayer ?  _playerInstance;
  late String filePath ; 
  AudioPlayer get _player {
    _playerInstance ??= AudioPlayer();
    return _playerInstance! ;
  } 
  


  TrackSpot(this.name, this.id, this.uri);

  TrackSpot.fromTrack(Track x)
      : name = x.name,
        id = x.id,
        uri = x.uri;
  TrackSpot.fromTrackSimple(TrackSimple x)
      : name = x.name,
        id = x.id,
        uri = x.uri;

  static Future<TrackSpot> fromTrackLinkNameInit(TrackLink x,SpotifyApi y) async {
   return  TrackSpot(x.id,x.uri,await (await y.tracks.get(x.id as String)).name);
  }

  TrackSpot.fromYoutubeId(String ytId){
    //TO DO 
  }
  TrackSpot.SongName(String name ){
    //TO DO 
  }

  Future SaveFile()async{

     String ytId =  await YoutubeOps.getYoutubeId(this);
    filePath  = await  YoutubeOps.saveVideo(ytId); 

  }


  void playSong(){
    _player.play();
  }
  Future  loadSong()async{

   await  _player.setFilePath(filePath);
  }
  Future seekSong(Duration ? position , {bool fromStart = false})async{
    if (fromStart){
      _player.seek(const Duration(seconds: 0,minutes: 0));
    }
    else {
      await _player.seek(position);
    }     
  }
  Future  pauseSong()async{
    await _player.pause();
  }

}
