import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test323232/Objects/track_object.dart';
import 'package:test323232/exceptions.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as ytl;
class YoutubeOps{


   static final Map<String,String> _taken ={};
   static final   RegExp  _youtubeReg = RegExp('''\"videoId\"\:\"[\\w]{11}\"''');
   static const _youtubeQueryUri = "https://www.youtube.com/results?search_query=";





   static void realseSongSpace(String key){
     if(_taken.containsKey(key)){
       _taken[key]="";
     }
     else {
       throw IndexError(int.parse(key.substring(4)),"No such Key in FileStack");
     }

   }
    static void initYotubeOps(int stackSize){
      if(stackSize <= 0 )
      {
          throw StackSizeTooSmall();

      }
        for(int i=0;i<stackSize;i++){
          _taken["song$i"] ="";
        }

    }
   static getFirstEmptySpace(){
     for(var key in _taken.keys){
       print(_taken[key]);
        if(_taken[key]! == ""){
          return key;
        }       
     }
      throw FileStackOverFlow();

   }

    static Future<String> getYoutubeId(TrackSpot  track)async{  
              final youtubeCode = await http.read(Uri.parse("$_youtubeQueryUri${track.name}"));
              Iterable<RegExpMatch> regexMatches = _youtubeReg.allMatches(youtubeCode);
              String VideoId = youtubeCode
                  .substring(regexMatches.first.start,regexMatches.first.end)//to find all of the first regex result from the whole scraped js file .
                  .substring(11, 22); // to find only the ytID code from the whole regex .
              print(VideoId);
        return VideoId;

    }
    static Future<String> getYoutubeIdString(String name )async{
              final youtubeCode = await http.read(Uri.parse("$_youtubeQueryUri${name}"));
              Iterable<RegExpMatch> regexMatches = _youtubeReg.allMatches(youtubeCode);
              String VideoId = youtubeCode
                  .substring(regexMatches.first.start,regexMatches.first.end)//to find all of the first regex result from the whole scraped js file .
                  .substring(11, 22);// to find only the ytID code from the whole regex .
              print(VideoId);

        return VideoId;

    }
    static Future<String> saveVideo(String idParam )async{
      print("helllo");
                    var yt = ytl.YoutubeExplode();
              var manifest2 = await yt.videos.streamsClient
                  .getManifest(ytl.VideoId(idParam));
              var audio2 = manifest2.audioOnly.last;
              print(audio2.size);
              await Permission.storage.request();
              print(VideoId);
              var id = ytl.VideoId(idParam);
              // Get the streams manifest and the audio track.
              var manifest = await yt.videos.streamsClient.getManifest(id);
              var audio = manifest.audioOnly.last;
              var video = await yt.videos.get(id);
              // Build the directory.
              Directory appDocumentsDirectory =
                  await getApplicationDocumentsDirectory(); // 1
              String appDocumentsPath = appDocumentsDirectory.path; // 2
                  String fileKey = getFirstEmptySpace();
              _taken[fileKey] = audio.container.name;
              String filePath = 
                  '$appDocumentsPath/$fileKey.${audio.container.name}'; // 3
              print(filePath);
              var file = File(filePath);
              var fileStream = file.openWrite();
              await yt.videos.streamsClient.get(audio).listen((event) {
                print("audio: " + event.join(""));
              });
              await yt.videos.streamsClient.get(audio).pipe(fileStream);
              await fileStream.flush();
              await fileStream.close();

              yt.close();
              return filePath;
    }
    static Future<String> saveVideoVideoId(ytl.VideoId id)async{
                    var yt = ytl.YoutubeExplode();
              var manifest2 = await yt.videos.streamsClient
                  .getManifest(id);
              var audio2 = manifest2.audioOnly.last;
              print(audio2.size);
              await Permission.storage.request();
              print(id);  
              // Get the streams manifest and the audio track.
              var manifest = await yt.videos.streamsClient.getManifest(id);
              var audio = manifest.audioOnly.last;
              var video = await yt.videos.get(id);
              // Build the directory.
              Directory appDocumentsDirectory =
                  await getApplicationDocumentsDirectory(); // 1
              String appDocumentsPath = appDocumentsDirectory.path; // 2

              String fileKey = getFirstEmptySpace();
              _taken[fileKey] = audio.container.name;
              String filePath = 
                  '$appDocumentsPath/$fileKey.${audio.container.name}'; // 3
              print(filePath);
              var file = File(filePath);
              var fileStream = file.openWrite();
              await yt.videos.streamsClient.get(audio).listen((event) {
                print("audio: " + event.join(""));
              });
              await yt.videos.streamsClient.get(audio).pipe(fileStream);
              await fileStream.flush();
              await fileStream.close();

              yt.close();
              return filePath;

    }


}