import 'package:test323232/Objects/total_pack.dart';

class songMannger{

  static late List<TotalPack ? > _songsNext;
  static late List<TotalPack ?> _songsPrev ;
  static  int loadedNextSongs = 0 ; 
  static TotalPack ? _current ; 
  static initSongMannger({required int sizeNext ,required int sizePrev } ){
      _songsNext = List.filled(sizeNext, null); 
      _songsPrev = List.filled(sizePrev, null); 
  }
  static TotalPack ? get current{
    return _current ; 
  }

  Stream<int>  _firstInit(){
    //TO DO 

  }

  static Future getNextSong(){
    //TO DO 

  }

  static bool getprevsong(){
    //TO DO 


  }

  static bool isThereAnySongs(){
    //TO DO 



  } 








}