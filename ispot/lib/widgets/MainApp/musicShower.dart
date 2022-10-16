import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:insta_dart/insta_dart.dart';
import 'package:ispot/design/color.dart';
import 'package:ispot/widgets/instgram/instagram_profile_show.dart';
import 'package:spotify/spotify.dart' as spot;


class MusicShower extends StatefulWidget {
  final spot.Track trk ; 
  const MusicShower( this.trk , {Key? key}) : super(key: key);
  

  @override
  State<MusicShower> createState() => _MusicShower();
}

class _MusicShower extends State<MusicShower> {
  
  final _indexArtistNotifer = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar( 
        title:SizedBox(height : 100  , child: 
          Row(
            
            children:
             List.generate(
              widget.trk.artists?.length ?? 0 , 
              (index) => Expanded(child: 
                  TextButton(
                      onPressed: (){_indexArtistNotifer.value = index; } , 
                      child: Text(widget.trk.artists?[index].name ?? "None",style: TextStyle(fontSize: 10,color: Colors.black)))))))),
      body: Column(
        children: [
          Expanded(flex:5, child:
          ValueListenableBuilder(
            valueListenable: _indexArtistNotifer,
            builder: (context , int value , _)=> 
             FutureBuilder(
            future: InstgramOperator.findInstaName(widget.trk.artists?[value].name ?? "dronesOriginal"),
          builder: (context, snapshot) {
                if(snapshot.data == null ){
                  return CircularProgressIndicator();
                }
                return ProfileShow(snapshot.data as InstaObject);
              }
          
            ),
          )),
          Expanded(flex:1 , 
          child: 
          Container(color: spotifyMain,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children:[
                  Expanded(child: Image.network(widget.trk.album!.images!.first.url as String,fit: BoxFit.fill, ),),
                  Expanded(child: Center(child: Text(widget.trk.name as String)),)
                  ]


                )),
                Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        Expanded(
                          child: IconButton(icon:Icon(Icons.skip_previous),onPressed: (){},)
                        ),
                               Expanded(
                          child: IconButton(icon:Icon(Icons.play_arrow),onPressed: (){},)
                        ),
                               Expanded(
                          child: IconButton(icon:Icon(Icons.skip_next),onPressed: (){},)
                        )


                    ],


                )



                )


              ],



            )
          
          
          ),),
        ]
    
    
    
    
      ),
    );
  }
}
