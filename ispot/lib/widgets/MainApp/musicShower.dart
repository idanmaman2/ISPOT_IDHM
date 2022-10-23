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

class _MusicShower extends State<MusicShower> with SingleTickerProviderStateMixin {
  
  final _indexArtistNotifer = ValueNotifier<int>(0);
   late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 15000),
      vsync: this,
    );
    _controller.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  


  @override
  Widget build(BuildContext context)  {
    return      DefaultTabController(  length: widget.trk.artists?.length ?? 0 ,  
    child : Scaffold(
      appBar: AppBar( 
        title:SizedBox(height : 200  , child:  
              TabBar(
              tabs: 
              List<Tab>.generate(
              widget.trk.artists?.length ?? 0 , 
              (index) => 
                Tab(
                  child: FittedBox(
                    child: Text("${widget.trk.artists?[index].name}",),
                    fit:BoxFit.fitWidth
                  ), 
                    )
              
              
              )
           ) , 
           
        )),
         
      body: Stack(
        children: [
          Center(
            child: RotationTransition(
                  turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
                  child: ClipOval(child: Image.network(widget.trk.album!.images!.first.url as String,fit: BoxFit.fill,))),
          )
          
          ,Container(
            color:spotifySecondry.withOpacity(0.3),
            child: Column(
            children: [
              Expanded(flex:5, child:
              
               
              TabBarView(
      
                children : 
               List.generate(widget.trk.artists?.length ?? 0 ,   (index)=>  FutureBuilder(
                future: InstgramOperator.findInstaName(widget.trk.artists?[index].name ?? "dronesOriginal"),
              builder: (context, snapshot) {
                    if(snapshot.data == null ){
                      return CircularProgressIndicator();
                    }
                    return ProfileShow(snapshot.data as InstaObject);
                  }
              
                )),
              )),
              Expanded(flex:1 , 
              child: 
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [spotifySecondry,spotifyMain],tileMode: TileMode.mirror,end: Alignment.topCenter)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:[
                      Expanded(child: SizedBox(height :30 , width : 20 ,child: ClipOval(child: Image.network(widget.trk.album!.images!.first.url as String,fit: BoxFit.fill, ))),),
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
          ),]
      ),
      
      ),
    );
  }
}
