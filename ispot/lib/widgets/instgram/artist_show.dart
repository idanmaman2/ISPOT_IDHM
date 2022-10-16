import 'package:flutter/material.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:insta_dart/insta_dart.dart';
import 'package:ispot/widgets/instgram/providers/instgram_profile_show_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as spotify;

import '../../design/color.dart' as colorpallet;


class ArtistShow extends StatelessWidget {
  final String name;
  ArtistShow(this.name);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:TextButton(
        child: Icon(Icons.arrow_back),
        onPressed: ()=>Navigator.pop<void>(
        context) ,
      ), 
      ),
      
      
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          
          children:[
            Text(name,style: TextStyle(fontSize: 60),),
            Icon(Icons.facebook,size: 30,)
          
          
          
          ]),
      ));
  }
}

