import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ispot/objects/spotify/spot.dart';







class SpotifyLogin extends StatelessWidget {
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
  SpotifyLogin() {
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
        navigationDelegate: (navReq) {
          if (navReq.url.startsWith(redirectUri)){         
            final spotify = spot.getSpotInstance(grant: grant ,url: navReq.url);
            spotify.me.currentlyPlaying().then((x) async {
              print("hello");
     
              //await spot.initSongs();
              //TrackSpot track =spot.getNextSong();
              //YoutubeOps.initYotubeOps(1);
              //await track.saveFile();
              //await track.loadSong();
             //InstaObject insta = await InstaObject.fromInstaUserName(await InstaObject.findInstaName(track.singersFullName.first));
             //print("deploayed 1");
              //String VideoId = await YoutubeOps.getYoutubeIdString(track.name!);
              //print(VideoId);

            //  Navigator.push<void>(
              //  context,
               // MaterialPageRoute<void>(
                 //   builder: (BuildContext context) => 
                   //         MusicPlayerWarpper(
                     //         maxValueSecs: track.durationOfSong().inSeconds.toDouble(),    
                       //       pos:track.durationOfSongCurrent(),
                         //     pressNext: spot.getNextSong,
                           //   pressPrev:spot.getPrevSong,
                             // pressCurrent: spot.getCurrentSong,
                             // sliderChange: (x){ track.seekSong(Duration(seconds: x.toInt()) )  ;   },
                             // pressPausePlay:track.pausePlayAuto,
                             // state : track.stateOfSongCurrent() , 
                             // screen: insta.StreamBio(5  , 50),
                         // warp: ProfileShow(
                         // VideoId,
                         // insta: insta,
                         // spot: spotify,
                        //),)),
              //);

  
              //track.playSong();
           

    
  
            });

            return NavigationDecision.prevent;
          }

          return NavigationDecision.navigate;
        },
      ),
     
    );
  }
}
