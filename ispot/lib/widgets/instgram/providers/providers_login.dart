import 'package:flutter/material.dart';
import 'package:insta_dart/insta_dart.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../spotify/spotify_login.dart';

class InstgramLoginProvider extends ChangeNotifier {
  Future nextScreen(context,
      {NavigationRequest? navReq, InstgramMannger? insta}) async {
    if (insta != null && navReq != null) {
      insta.code = navReq.url;
      insta.fromCode;
    }

    // going to the next login page
    Navigator.pop(context); //no back to that page
    Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => const SpotifyLogin()));
  }
}
