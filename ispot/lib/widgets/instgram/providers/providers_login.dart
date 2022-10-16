import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:insta_dart/insta_dart.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../spotify/spotify_login.dart';

class InstgramLoginProvider extends ChangeNotifier {
  void nextScreen(context,
      {NavigationRequest? navReq, InstgramMannger? insta})  {
    if (insta != null && navReq != null) {
      insta.code = navReq.url;
      insta.fromCode;
    }
jumpToFuture(context);
  
  }

  void  jumpToFuture(context){

  // going to the next login page
   SchedulerBinding.instance.addPostFrameCallback((_){
Navigator.pop(context); //no back to that page
    Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const SpotifyLogin()));

  
   }); 
     }


}
