import 'package:test323232/Objects/instgram_object.dart';
import 'package:test323232/Objects/track_object.dart';

class TotalPack{
  final bool valid ; 
  final TrackSpot  ? track ; 
  final InstaObject ? insta ; 
  TotalPack(this.track , this.insta):valid = (track != null && track.filePath != null && track.isLoaded() && insta !=null) ; 




} 