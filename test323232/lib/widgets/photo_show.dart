import 'package:flutter/material.dart';

class PhotoShow extends StatelessWidget {
  final Image x;
  const PhotoShow({Key? key, required Image x})
      : x = x,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: 
      FittedBox(
        fit: BoxFit.cover,
        child: x,     
    ));
  }
}
