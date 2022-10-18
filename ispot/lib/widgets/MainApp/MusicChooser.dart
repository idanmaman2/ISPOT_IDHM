    

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ispot/design/color.dart';
import 'package:ispot/widgets/MainApp/TracksShow.dart';
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
                        backgroundColor: spotifySecondry,
                        title : Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient( end : Alignment.center,tileMode: TileMode.mirror, colors: [spotifyMain,spotifySecondry] )
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                        Expanded(flex:2 , child:Text("Ispot")),
                        Spacer(flex:1),
                            Expanded(child:Image.asset("assets/lofo.png",height: 50 ,width: 50,)),
                                            Spacer(flex:1),        
                              Expanded(flex:2,
                                child: Container(
                                  height: 50,
                                  width: 150,
                                  decoration: BoxDecoration(                        
                                  
                                      borderRadius: BorderRadius.all(Radius.circular(15),)),
                                  
                                  child: Center(child: Text(me.displayName ?? "" ,style: TextStyle(fontSize: 25 , fontWeight: FontWeight.w100),))),
                              ),
                            ],
                          ),
                        ),
                      ),
                      body : Container(
                        color:spotifySecondry,
                        child: CustomScrollView(
      slivers: <Widget>[
       SliverAppBar(
        pinned: false,
        expandedHeight: 350.0,
        
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            color: spotifyMain,
          ),
          title:Column(
            children: [
             const  Spacer(flex:4 ),
              const Expanded(flex : 1 , child: Align(alignment :Alignment.centerLeft , child: Text("Last played Artists ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800) ,))) , 
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

                            if(snapshot.connectionState == ConnectionState.done  ){
                                spot.Artist ? art = snapshot.data as spot.Artist ?  ; 
                                return GestureDetector(
                                  onTap: ()async{
                                    if(art is  spot.Artist){
                                    Iterable<spot.Track> trs = (await spotify.artists.getTopTracks(art.id!, "IL"));
            
                                       Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => TracksShow(trs ),
        ));
                                    
                                    }

                                  },
                                  child: ArtistCard( dirHor: true ,round : true ,fg :spotifySecondry ,  bg :spotifyMain ,  name: art?.name ?? "", imageURL: art?.images?.first.url ?? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png"));
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
           
             SliverAppBar(
        pinned: false,
        expandedHeight: 300.0,
        
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            color: spotifySecondry,
          ),
          title:Column(
            children: [
             const  Spacer(flex:4 ),
              const Expanded(flex : 1 , child:Align(alignment :Alignment.centerLeft , child: Text("Featured  playlist ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800) ,))) , 
              const Spacer(flex:1),
              Expanded(flex : 4 , child: FutureBuilder(
                future: spotify.playlists.featured.all(50) , 
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    Iterable<spot.PlaylistSimple> featured= snapshot.data as Iterable<spot.PlaylistSimple> ;
                   
                    return ListView(
                        scrollDirection: Axis.horizontal,

                        children: List.generate(featured.length,( index){
                        

                                return GestureDetector(
                                  onTap: ()async{
                                   
                                   spot.Pages<spot.Track> ps = (await spotify.playlists.getTracksByPlaylistId(featured.skip(index).first.id!));
                                    Iterable<spot.Track> trks = (await ps.first(50)).items!; 
                                       Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => TracksShow(trks ),
        ));
                                   

                                  },
                                  child: ArtistCard(fg : spotifyMain ,  bg :spotifySecondry ,  name: featured.skip(index).first.name ?? "", imageURL:  featured.skip(index).first.images?.first.url ?? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png"));
                         

                    }));
                  }
                  return CircularProgressIndicator();
                  
                }),



              )

            ],
          )
        ),
             )
      
                   ,SliverAppBar(
        pinned: false,
        expandedHeight: 300.0,
        
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            color: spotifyMain,
          ),
          title:Column(
            children: [
             const  Spacer(flex:4 ),
              const Expanded(flex : 1 , child:Align(alignment :Alignment.centerLeft , child: Text("My Playlists ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800) ,))) , 
              const Spacer(flex:1),
              Expanded(flex : 4 , child: FutureBuilder(
                future: spotify.playlists.me.all() , 
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    Iterable<spot.PlaylistSimple> featured= snapshot.data as Iterable<spot.PlaylistSimple> ;
                   
                    return ListView(
                        scrollDirection: Axis.horizontal,

                        children: List.generate(featured.length,( index){
                        

                                return GestureDetector(
                                  onTap: ()async{
                                   
                                   spot.Pages<spot.Track> ps = (await spotify.playlists.getTracksByPlaylistId(featured.skip(index).first.id!));
                                    Iterable<spot.Track> trks = (await ps.first(50)).items!; 
                                       Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) =>  TracksShow(trks ),
        ));
                                   

                                  },
                                  child: ArtistCard( dirHor: false,round: false ,fg : spotifySecondry ,  bg :spotifyMain ,  name: featured.skip(index).first.name ?? "", imageURL:  featured.skip(index).first.images?.first.url ?? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png"));
                         

                    }));
                  }
                  return CircularProgressIndicator();
                  
                }),



              )

            ],
          )
        ),
             )
                   
              
                    ,SliverAppBar(
        pinned: false,
        expandedHeight: 350.0,
        
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            color: spotifySecondry,
          ),
          title:Column(
            children: [
             const  Spacer(flex:4 ),
              const Expanded(flex : 1 , child: Align(alignment :Alignment.centerLeft , child: Text("Top played Artists ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800) ,))) , 
              const Spacer(flex:1),
              Expanded(flex : 4 , child: FutureBuilder(
                future: spotify.me.topArtists() ,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done){
                    Iterable arts= snapshot.data as Iterable<spot.Artist> ;
        
                   
                    return ListView(
                        scrollDirection: Axis.horizontal,

                        children: List.generate(arts.length,( index){
                           
                       
                                return GestureDetector(
                                  onTap: ()async{
                                    if(arts.skip(index).first is  spot.Artist){
                                    Iterable<spot.Track> trs = (await spotify.artists.getTopTracks(arts.skip(index).first.id!, "IL"));
                                    spot.Track trks = trs.first ; 
                                       Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => TracksShow(trs),
        ));
                                    
                                    }

                                  },
                                  child: ArtistCard( dirHor: true ,round : true ,fg :spotifyMain ,  bg :spotifySecondry ,  name: arts.skip(index).first?.name ?? "", imageURL: arts.skip(index).first?.images?.first.url ?? "https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled.png"));
                        
                      

                          } )

                );
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
