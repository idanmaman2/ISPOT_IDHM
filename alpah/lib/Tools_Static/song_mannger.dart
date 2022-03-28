import 'package:test323232/Objects/total_pack.dart';
import 'package:test323232/Tools_Static/spot.dart';
import 'dart:collection';

import 'package:test323232/Tools_Static/youtube_ops.dart';

//TO DO : use and crete exeptions 

class SongMannger{

  static final  Queue<TotalPack> _songsNext = Queue() ; 
  static final  Queue<TotalPack> _songsPrev = Queue() ; 
  static  int _loadedNextSongs = 0 ; 
  static TotalPack ? _current ; 
  static late int songsPrevSize ; 
  static late  int songsNextSize ; 

  static int get loaded => _loadedNextSongs ; 

  static initSongMannger({required int sizeNext ,required int sizePrev } ){
    songsPrevSize = sizePrev ; 
    songsNextSize = sizeNext ; 
    _firstInit().listen((event) { 
      _loadedNextSongs = event ; 
    });
    YoutubeOps.initYotubeOps(sizeNext+sizePrev+1);
  }

  static TotalPack ? get current{
    return _current ; 
  }

  static Stream<int>  _firstInit()async*{
    for(int i=0; i < songsNextSize ; i++){
      TotalPack pack = await TotalPack.fromTrackSpot(spot.getNextSong());
      if(_songsNext.length < songsNextSize )  {
          _songsNext.addLast(pack);
          pack.track?.saveFile();
        }
        _songsNext.addLast(pack); 
      yield  i ; 
    } 

  }

  static Future<TotalPack> getNextSong()async{
    if(_songsNext.length >= 1 ){
      if(current != null){
        _songsPrev.addLast(current!); 
        if(_songsPrev.length > songsPrevSize){
          TotalPack packRm = _songsPrev.removeFirst();
          packRm.track?.realse();
        }
      }
      
      TotalPack.fromTrackSpot(spot.getNextSong()).then((packAdd) {
        print("entered to next");
        if(_songsNext.length < songsNextSize )  {
            _songsNext.addLast(packAdd);
            packAdd.track?.saveFile();
        }

        
        }  
        
        );
      TotalPack packNext = _songsNext.removeFirst();
      _current = packNext ;
      await packNext.track?.loadSong();  
    return packNext ; 
    }
    else {
      return _current!; 
    }



  }

  static TotalPack  getprevsong(){

      if(_songsPrev.isNotEmpty)
      {
          TotalPack pack = _songsPrev.removeLast(); 
          if(current != null){
            _songsNext.addFirst(current!); 
            _current = pack ; 
            if(_songsNext.length > songsNextSize){
              TotalPack packRm =  _songsNext.removeLast();
               packRm.track?.realse();
            }
          return pack; 
      }
      throw ArgumentError(); 

      } 
    else {
      throw ArgumentError();
    } 


  }

  static bool isThereAnySongs(){
    return _songsNext.isEmpty ; 
  } 

}