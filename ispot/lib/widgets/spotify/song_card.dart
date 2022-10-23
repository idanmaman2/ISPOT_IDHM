


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


   return Card(
        
          child: 
          
          Container(
            color: _bg,
            child: ConstrainedBox(
  constraints: new BoxConstraints(
    minHeight: 200,

    maxHeight: 300.0,

  ),
 
              child: Container(
                
                decoration: BoxDecoration(
                  image:DecorationImage(
                    image:NetworkImage(trk.album!.images!.first.url!),
                    fit: BoxFit.cover
                  ) ,
                  border: Border.all(color:_bg.withBlue(3),width: 10),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                   color: _fg.withOpacity(0.80), 
                ),
                width: double.infinity,
                
                child: Row(
                  children: [
                    Expanded(flex : 3 , child: FittedBox(fit:BoxFit.fitWidth,child:TextButton(onPressed: (){}, child:FittedBox(fit:BoxFit.fitWidth,child:Text(_index.toString().padLeft(2,"0"),style: TextStyle( color: Colors.white,fontWeight: FontWeight.w800),))) )),

                    Expanded(flex:5 , child:  Center(
                      child: Stack(
                        children:[
                          Text(trk.name!,style: TextStyle( fontSize :30 , fontWeight: FontWeight.w900 ,foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 6
                                ..color = Colors.black,),),
                                
                                Text(trk.name!,style: TextStyle( fontSize :30 , fontWeight: FontWeight.w900 ,color:spotifyMain))
                                
                                
                                ]
                      ),
                    )),
                    Spacer(flex:1),
                    Expanded(flex:2 , child: FittedBox(fit:BoxFit.fitWidth,child:Text("${trk.duration?.inMinutes ?? 0 }:${"${(trk.duration?.inSeconds?? 0) %60 }".padLeft(2,"0")}" ,style:TextStyle(color: Colors.white))))
            
            
                 
                 
                  ],
                ),
                   
            
            
            
              ),
            ),
          ),
        );
         
      
    


  

  }

}
