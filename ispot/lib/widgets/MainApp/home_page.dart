import 'package:flutter/material.dart';
import 'package:insta_dart/insta_dart.dart';
import 'package:spotify/spotify.dart';

import '../instgram/InstgramProfileShow.dart';

class IspotHomePage extends StatelessWidget {
  InstaObject insta;
  SpotifyApi spot;
  IspotHomePage(this.insta, this.spot, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileShow(insta),
    );
  }
}
