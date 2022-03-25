import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:spotify/spotify.dart';
import 'package:test323232/Objects/instgram_object.dart';
import 'package:test323232/Objects/track_object.dart';
import 'package:test323232/Tools_Static/youtube_ops.dart';
import 'package:test323232/widgets/audio_player_warpper.dart';
import 'package:test323232/widgets/error_page.dart';
import 'package:test323232/widgets/instgram_page.dart';
import 'package:test323232/Tools_Static/spot.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as ytl;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "hi"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var keyJson;
  var keyMap;
  var credentials;
  var grant;
  final  redirectUri = 'https://github.com/asimon655/dotNet5782_3715_6941';
   var authUri;
  final scopes = const [
    'user-library-read',
    'user-read-currently-playing',
    'user-read-recently-played',
    'playlist-read-private',
    'user-top-read'
  ];
  _MyHomePageState() {
    credentials = SpotifyApiCredentials(
        "faacc54f879248a2b00b8d4acced093b", "5356a6e50a19497e84fa34b38136e1c4");
    grant = SpotifyApi.authorizationCodeGrant(credentials);
    authUri = grant.getAuthorizationUrl(
      Uri.parse(redirectUri),
      scopes: scopes, // scopes are optional
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: authUri.toString(), 
        userAgent:"Mozilla/5.0 (Linux; Android 8.0.0; SM-G960F Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.84 Mobile Safari/537.36",
        navigationDelegate: (navReq) {
          if (navReq.url.startsWith(redirectUri)){         
            final spotify = spot.getSpotInstance(grant: grant ,url: navReq.url);
            spotify.me.currentlyPlaying().then((x) async {
     
              await spot.initSongs();
              TrackSpot track =spot.getNextSong();
              YoutubeOps.initYotubeOps(1);
              await track.saveFile();
              await track.loadSong();
             InstaObject insta = await InstaObject.fromSpotifyUserName(track.singersFullName.first);
              String VideoId = await YoutubeOps.getYoutubeIdString(track.name!);
              print(VideoId);

              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => 
                            MusicPlayerWarpper(
                              maxValueSecs: track.durationOfSong().inSeconds.toDouble(),    
                              pos:track.durationOfSongCurrent(),
                              pressNext: spot.getNextSong,
                              pressPrev:spot.getPrevSong,
                              pressCurrent: spot.getCurrentSong,
                              sliderChange: (x){ track.seekSong(Duration(seconds: x.toInt()) )  ;   },
                              pressPausePlay:track.pausePlayAuto,
                              state : track.stateOfSongCurrent() , 
                          warp: ProfileShow(
                          VideoId,
                          insta: insta,
                          spot: spotify,
                        ),)),
              );

  
              track.playSong();
           

    
  
            });

            return NavigationDecision.prevent;
          }

          return NavigationDecision.navigate;
        },
      ),
     
    );
  }
}
