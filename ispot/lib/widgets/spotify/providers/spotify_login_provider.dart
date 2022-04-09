import 'package:flutter/material.dart';
import 'package:insta_dart/insta_dart.dart';
import 'package:ispot/objects/spotify/spot.dart';
import 'package:ispot/widgets/MainApp/home_page.dart';
import 'package:spotify/spotify.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpotifyLoginProvider extends ChangeNotifier {
  Future LoadToken(dynamic grant, NavigationRequest navReq) async {
    final spotify = spot.getSpotInstance(grant: grant, url: navReq.url);
  }

  Future nextScreen(context) async {
    InstaObject instgram = await InstgramOperator.findInstaName("noa kirel");
    SpotifyApi spotify = spot.getSpotInstance();
    Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => IspotHomePage(instgram, spotify),
        ));
  }
}
