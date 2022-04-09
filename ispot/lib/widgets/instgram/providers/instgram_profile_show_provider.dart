import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insta_dart/insta_dart.dart';

import '../InstgramProfileShow.dart';

class InstgramProfileShowProvider extends ChangeNotifier {
  Widget creator(context, String x) {
    Image img = Image.network(
      x,
      fit: BoxFit.fill,
    );
    return InkWell(
      child: img,
      onTap: () => Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => PhotoShow(x: img)),
      ),
    );
  }
}
