


import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ispot/design/color.dart';
import 'package:spotify/spotify.dart' as spot ;

class songCard extends StatelessWidget {
 final spot.Track trk ; 
 final Color _bg ; 
 final Color _fg ; 
 final int _index ; 
   songCard(this.trk , { required int index , required Color bg , required Color fg ,   Key? key}) :_index = index , _bg= bg, _fg=fg , super(key: key);
  
  @override
  Widget build(BuildContext context) {
    Random random = Random();

   return Card(
        
          child: 
          
          Container(
            color: _bg,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                 color: _fg.withOpacity(0.80), 
              ),
              width: double.infinity,
              height: 150 ,
              child: Row(
                children: [
                  Expanded(child: Text(_index.toString(),style: TextStyle(fontSize: 20 , fontWeight: FontWeight.w600),)) ,
                  Expanded(flex : 3 , child: Padding(padding: EdgeInsets.all(20), child: ClipOval(child: Image.network(trk.album!.images!.first.url!,fit:BoxFit.fill)))),
                  Spacer(flex:1),
                  Expanded(child: Text(trk.name!)),
                  Spacer(flex:1),
                  Expanded(child: Text("${trk.duration?.inMinutes ?? 0 }:${(trk.duration?.inSeconds ?? 0) %60 }"))


               
               
                ],
              ),
       



            ),
          ),
        );
         
      
    


  

  }

}

