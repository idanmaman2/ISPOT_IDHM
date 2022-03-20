import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test323232/Objects/track_object.dart';
import 'package:test323232/exceptions.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as ytl;
class YoutubeOps{


   static final Map<String,bool> taken ={};
    static void initYotubeOps(int stackSize){
        for(int i=0;i<stackSize;i++){
          taken["song$i"] =false;
        }

    }
   static getFirstEmptySpace(){
     for(var key in taken.keys){
        if(!taken[key]!){
          return key;
        }
            
     }
      throw FileStackOverFlow();

   }
    static final RegExp  youtubeReg = RegExp('''\"videoId\"\:\"[\\w]{11}\"''');
    static Future<String> getYoutubeId(TrackSpot  track)async{
      
              final youtubeCode = await http.read(Uri.parse(
                  "https://www.youtube.com/results?search_query=${track.name}"));
              String VideoId = youtubeCode
                  .substring(youtubeReg.allMatches(youtubeCode).first.start,
                      youtubeReg.allMatches(youtubeCode).first.end)
                  .substring(11, 22);
              print(VideoId);

        return VideoId;

    }
    static Future<String> getYoutubeIdString(String name )async{
                      final youtubeCode = await http.read(Uri.parse(
                  "https://www.youtube.com/results?search_query=$name"));
              String VideoId = youtubeCode
                  .substring(youtubeReg.allMatches(youtubeCode).first.start,
                      youtubeReg.allMatches(youtubeCode).first.end)
                  .substring(11, 22);
              print(VideoId);

        return VideoId;

    }
    static Future<void> saveVideo(String idParam )async{
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
              String filePath =
                  '$appDocumentsPath/${video.id}.${audio.container.name}'; // 3
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
    }
    static Future<void> saveVideoVideoId(ytl.VideoId id)async{
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
              String filePath =
                  '$appDocumentsPath/${video.id}.${audio.container.name}'; // 3
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

    }


}