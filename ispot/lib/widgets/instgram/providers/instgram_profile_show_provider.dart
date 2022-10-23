import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_dart/insta_dart.dart';

import '../artist_show.dart';
import '../instagram_profile_show.dart';

class InstgramProfileShowProvider extends ChangeNotifier {

   void Function()? artistInfo(context , String name ){
      return (){
        Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => ArtistShow(name)),
      );
      };

  }

  Widget creator(context, String x) {
    Image img = Image.network(
      x,
      fit: BoxFit.fill,
    );
    return InkWell(
      child: Opacity(opacity:0.88 , child: img),
      onTap: () => Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => PhotoShow(x: img)),
      ),
    );
  }
}
