    

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ispot/design/color.dart';
import 'package:ispot/widgets/MainApp/musicShower.dart';
import 'package:ispot/widgets/spotify/artist_card.dart';
import 'package:spotify/spotify.dart' as spot ;

class MusicChooser extends StatelessWidget {
 final  spot.SpotifyApi spotify ; 
  const MusicChooser(this.spotify , {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
             FutureBuilder(
              future: spotify.me.get(),
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done){
                   spot.User me = snapshot.data as spot.User  ; 
                   return Scaffold(
                      appBar: AppBar(
                        title : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(                        
                                  color:spotifySecondry,
                                  borderRadius: BorderRadius.all(Radius.circular(15),)),
                              
                              child: Center(child: Text(me.displayName ?? "" ,style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w100),))),
                          ],
                        ),
                      ),
                      body : Container(
                        color:spotifySecondry,
                        child: CustomScrollView(
      slivers: <Widget>[
       SliverAppBar(
        pinned: false,
        expandedHeight: 250.0,
        
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            color: spotifyMain,
          ),
          title:Column(
            children: [
             const  Spacer(flex:4 ),
              const Expanded(flex : 1 , child: Text("Last played",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800) ,)) , 
              const Spacer(flex:1),
              Expanded(flex : 4 , child: FutureBuilder(
                future: spotify.me.recentlyPlayed(limit: 50, after: DateTime.now().subtract(Duration(days: 1))),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    Iterable recentSongs= snapshot.data as Iterable<spot.PlayHistory> ;
                   List <Iterable<String>> artists = recentSongs.map((e) => (e as spot.PlayHistory).track!.artists!.map((e) => e.id! )).toList();
                   Set artistsPlayedSet  = {} ; 
                  for(var i in artists){
                    for(var j in i){
                          artistsPlayedSet.add(j);
                    }
                  }
                   
                    return ListView(
                        scrollDirection: Axis.horizontal,

                        children: List.generate(artistsPlayedSet.length,( index){
                          return 
                            FutureBuilder(future :spotify.artists.get(artistsPlayedSet.skip(index).first) , builder :(context,snapshot){

                            if(snapshot.connectionState == ConnectionState.done){
                                spot.Artist art = snapshot.data as spot.Artist ; 
                                return GestureDetector(
                                  onTap: ()async{
                                    Iterable<spot.Track> trs = (await spotify.artists.getTopTracks(art.id!, "IL"));
                                    spot.Track trks = trs.first ; 
                                       Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => MusicShower(trks),
        ));
                                    
                                 

                                  },
                                  child: ArtistCard(name: art.name!, imageURL: art.images?.first.url ?? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png"));
                            }
                            return CircularProgressIndicator();

                          } );

                    }));
                  }
                  return CircularProgressIndicator();
                  
                }),



              )

            ],
          )
        ),
      ),
    
      
      
      ],
    ),
                      ));
    
    
                   
    
    
    
    
    
    
    
                }
                return CircularProgressIndicator();
              },
            
          
    
    
    
    
      );





  }
}
