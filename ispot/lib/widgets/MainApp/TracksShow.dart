
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ispot/design/color.dart';
import 'package:ispot/widgets/MainApp/musicShower.dart';
import 'package:ispot/widgets/instgram/instagram_profile_show.dart';
import 'package:ispot/widgets/spotify/song_card.dart' ;
import 'package:spotify/spotify.dart' as spot ;
import 'package:flutter/services.dart' ;

class TracksShow extends StatelessWidget {
 final  Iterable<spot.Track> tracks ; 
 final String _name ; 
 final Image cover ; 
  const TracksShow(this.tracks,this.cover , this._name  , {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
   

      body : Container(
        color:spotifySecondry,
        child: CustomScrollView(
          slivers: [
           
         SliverAppBar(
          elevation: 0,

          backgroundColor: spotifyMain,

          expandedHeight: 250.0,
          
          flexibleSpace: FlexibleSpaceBar(
            
            titlePadding: const EdgeInsets.all(0),
            background: Container(
              decoration: BoxDecoration(
                
              color: spotifyMain,
              
              ),
            
              child: Column(
        
                children: [
                  Expanded(flex:5,child: Container( 
                    margin:const  EdgeInsets.all(0),
                    
                    decoration: BoxDecoration(
                      
                     color:spotifySecondry, 
                      border: Border.all(color:spotifySecondry),
                    ),
                    padding: EdgeInsets.all(0),),),
  
                 Expanded(
                  flex:6,
                   child: Stack(
                     children: [
                   

                       Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          
                          image: DecorationImage(
                            image:cover.image ,
                            fit: BoxFit.fitWidth,
                          ),
                          borderRadius: BorderRadius.all(Radius.elliptical(10,15)),
                          border: Border.all(width: 5,color: spotifyMain)
                        ),
                         child: Column(
                           children: [
                            const Spacer(flex:5),
                            const Spacer(),
                             Expanded(flex:4,child: ClipOval(child:  Container(width: 75 , height: 75, color :spotifySecondry ,child:const  Icon(Icons.play_arrow,size:50,color:Colors.white)))),
                           const Spacer(),
                           ],
                         ),
                       ),
                        Column(children:[
                     
                                      Expanded(flex:5, 
                  child: Container(
                    
                    margin:const  EdgeInsets.all(0),
                    padding: const EdgeInsets.all(0),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border: Border.all(color:spotifySecondry,width: 15),
                      color: spotifySecondry,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.elliptical(30,50),bottomRight: Radius.elliptical(30,50))
                    ),
                    
                    child: FittedBox(child: Text(_name,style: const TextStyle(color:Colors.white,fontWeight: FontWeight.w900),),fit:BoxFit.fitWidth))),
 Spacer(flex:6),
                    ]

                        ),

                     ],
                   ),
                 )
               
                ],
              ),
            ),
            
            title:Container())),
            SliverList(delegate:  SliverChildBuilderDelegate(
            (BuildContext context, int index) => GestureDetector(onTap: (){
          Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => MusicShower(tracks.skip(index).first),
        ));

        } , child:   Padding(padding: EdgeInsets.fromLTRB(5, 5, 5, 5),child: songCard(tracks.skip(index).first,index:index+1 , bg:spotifySecondry ,fg:(index%2 ==1 ? spotifySecondry : spotifyMain)))),
            childCount: tracks.length,
          ),)
          ]),
      )
      );
      
      
      
  
  }
}