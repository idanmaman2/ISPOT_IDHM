
import 'package:spotify/spotify.dart' ;
import 'package:ispot/objects/spotify/spot.dart';
class TrackSpot {
  late String? name;
  late String? id;
  late String? uri;
  late String? originalPlayList;
  //AudioPlayer ?  _playerInstance;
  late Iterable<String> singersFullName ; 
  String ? filePath ; 
  //AudioPlayer get _player {
    //_playerInstance ??= AudioPlayer();
    //return _playerInstance! ;
  //} 
  


  TrackSpot(this.name, this.id, this.uri,this.singersFullName);

  Future<TrackSpot> fromSpotifyId(String id)async {
    Track track =  await  spot.getSpotInstance().tracks.get(id);
      return TrackSpot(track.name,id,track.uri,track.artists!.map((x)=> x.name!));
      
  }

  TrackSpot.fromTrack(Track x)
      : name = x.name,
        id = x.id,
        uri = x.uri , 
        singersFullName = x.artists!.map((x)=> x.name!);
  TrackSpot.fromTrackSimple(TrackSimple x)
      : name = x.name,
        id = x.id,
        uri = x.uri , 
        singersFullName = x.artists!.map((x)=> x.name!);

  static Future<TrackSpot> fromTrackLinkNameInit(TrackLink x,SpotifyApi y) async {
    Track track = await y.tracks.get(x.id as String);
   return  TrackSpot(x.id,x.uri,track.name,track.artists!.map((x)=> x.name!));
  }

 // TrackSpot.fromYoutubeId(String ytId){
 //   //TO DO 
 // }
  
 // TrackSpot.songName(String name ){
 //   //TO DO 
 // }

 // Future saveFile()async{

   //  String ytId =  await YoutubeOps.getYoutubeId(this);
   // filePath  = await  YoutubeOps.saveVideo(ytId); 

 // }

 // Future playSong()async{
    //await _player.play();
    
  //}
  
  //Duration durationOfSong(){
    //return _player.duration ?? const Duration();
  //}
    
 // Stream<Duration> durationOfSongCurrent(){
   // return _player.positionStream;
  //}
      
  //Stream<bool> stateOfSongCurrent(){
   // return _player.playingStream;
  //}
  
 // Future  loadSong()async{
  //if(filePath == null ){
   // throw ThereIsntFile();
 // } 
  // await  _player.setFilePath(filePath!);
  //}
  
   // bool   isLoaded(){
  //   return _player.currentIndex != null ; 
  //}
  
 // Future seekSong(Duration ? position , {bool fromStart = false})async{
   // if (fromStart){
     // _player.seek(const Duration(seconds: 0,minutes: 0));
    //}
  //  else {
    //  await _player.seek(position);
    //}     
 //}
  
 // Future  pauseSong()async{
  //  await _player.pause();
  //}
  
  //Future pausePlayAuto({bool ? stop , bool ? play} )async{
   // if(( _player.playing || ( stop ?? false ) )&& !(play ?? false) ){
    //  await pauseSong();
    //  return; 
  //  }
   // else {
    //  await playSong();
    //}
 // }

//void  realse () {
 //   if(filePath == null ){
 //   throw ThereIsntFile();
 // } 
//  String songName = filePath!.substring(filePath!.lastIndexOf('/')+1,filePath!.lastIndexOf('.')) ;
//  YoutubeOps.realse(songName);
//} 


}
