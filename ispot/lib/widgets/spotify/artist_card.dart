


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ispot/design/color.dart';

class ArtistCard extends StatelessWidget {
 final  String _name ; 
final String _imageURl; 



  const ArtistCard({required String name , required String imageURL ,  Key? key}) :_imageURl = imageURL , _name = name ,  super(key: key);
  
  @override
  Widget build(BuildContext context) {
   return Card(
        
          child: 
          
          Container(
            color: spotifyMain,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                 color: spotifySecondry.withOpacity(0.78), 
              ),
              width: 150 ,
             
              child: Row(
                children: [
                  Expanded(flex:2, child: ClipOval(child: Image.network(_imageURl))),
                  Spacer(flex:1 ),
                  Expanded(flex : 2, child: Align( alignment: Alignment.centerLeft,child: Text(_name, style: TextStyle(fontSize:15 , fontWeight: FontWeight.bold),)))
                ],
              ), 
            ),
          ),
        );
         
      
    


  

  }

}

