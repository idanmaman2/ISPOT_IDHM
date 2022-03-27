import 'package:test323232/Objects/instgram_object.dart';
import 'package:test323232/Objects/track_object.dart';

class TotalPack{
  
  bool valid = false  ; 
  final TrackSpot  ? track  ; 
  final InstaObject ? insta  ; 

  TotalPack(this.track , this.insta):valid = (track != null && track.filePath != null && track.isLoaded() && insta !=null) ; 

  static Future<TotalPack> fromTrackSpot(TrackSpot track )async{
      return TotalPack(track, await InstaObject.fromSpotifyTrack(track)); 
  } 

   void  reCheckValidation(){
    valid = track != null && track!.filePath != null && track!.isLoaded() && insta !=null;
  }
  



} 