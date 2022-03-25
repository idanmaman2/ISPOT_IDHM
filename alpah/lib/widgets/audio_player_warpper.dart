import 'package:flutter/material.dart';
import 'package:test323232/Decoration/colors.dart' as color_pallet;
import 'package:test323232/Objects/instgram_object.dart';
import 'package:test323232/Tools_Static/spot.dart';
import 'package:test323232/Objects/track_object.dart';
import 'package:test323232/widgets/instgram_page.dart';

import '../Tools_Static/youtube_ops.dart';
class MusicPlayerWarpper extends StatefulWidget {
  late Widget warp ;
  late TrackSpot Function() pressNext;
  late TrackSpot Function() pressPrev;
    late TrackSpot Function() pressCurrent;
  late Future  Function({bool ? stop , bool ? play}) pressPausePlay;
  late void Function(double) sliderChange;
  late double maxValueSecs ;
  late Stream<Duration> pos ;
  late Stream<bool> state ;
  MusicPlayerWarpper({
    Key? key,
    required this.warp, 
    required this.pressNext ,
    required this.pressPrev , 
    required this.pressCurrent , 
    required this.pressPausePlay ,
    required this.sliderChange ,
    required this.maxValueSecs, 
    required this.pos , 
    required this.state , 
    
                                }) : super(key: key);



    Future __init(TrackSpot track)async{
      InstaObject insta = await InstaObject.fromSpotifyUserName(track.singersFullName.first);
      warp = ProfileShow(
                          await YoutubeOps.getYoutubeId(track),
                          insta: insta,
                          spot: spot.getSpotInstance(),
                        ); 
      maxValueSecs = track.durationOfSong().inSeconds.toDouble();
      pos = track.durationOfSongCurrent();
      pressNext = spot.getNextSong;
      pressPrev = spot.getPrevSong;
      pressCurrent = spot.getCurrentSong;
      sliderChange = (x){ track.seekSong(Duration(seconds: x.toInt()) );};
      pressPausePlay = track.pausePlayAuto;
      state = track.stateOfSongCurrent() ; 
    }

  @override
  State<MusicPlayerWarpper> createState() => _MusicPlayerWarpperState();
}

class _MusicPlayerWarpperState extends State<MusicPlayerWarpper> {

  final ButtonStyle buttonStyleAppBar = ButtonStyle(
    padding: MaterialStateProperty.resolveWith<EdgeInsetsGeometry?>(
      (Set<MaterialState> states) {
        return const EdgeInsets.all(10);
      },
    )
 ,
    backgroundColor:  MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)){
           return color_pallet.spotifyMain.withOpacity(0.5);
        }
        return color_pallet.spotifyMain; // Use the component's default.
      },
    ),);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading :false, backgroundColor: color_pallet.spotifySecondry,toolbarHeight: MediaQuery.of(context).size.height * 0.05),
      body : Container(
        color : color_pallet.spotifySecondry , 
        child: Column ( children: [ 
          Expanded(
            child: widget.warp,flex:20),
        
        
        Expanded(flex:1 ,
          child:StreamBuilder<Object>(
            stream: widget.pos,
            builder: (context, snapshot) {
              if(snapshot.data != null && (snapshot.data as Duration).inSeconds <= widget.maxValueSecs ){
                  if( widget.maxValueSecs ==(snapshot.data as Duration).inSeconds ){ 
                 
                  widget.pressPausePlay(stop:true).then((x)async{   TrackSpot trackCurrent = widget.pressCurrent(); 
              trackCurrent.realse();
              TrackSpot trackNext = widget.pressNext();
                    widget.pressPausePlay(play:true);
                     await trackNext.SaveFile(); 
                     await trackNext.loadSong(); 
                      await widget.__init(trackNext);
                            setState(() {
               
                     });} );
                      widget.pressPausePlay(play:true );
           

                    return const CircularProgressIndicator();
             
                    

                  } 
                  return Slider( autofocus: true , 
                                activeColor:color_pallet.spotifyMain , 
                                thumbColor:Colors.transparent , 
                                min:0 , 
                                max: widget.maxValueSecs, 
                                value: (snapshot.data as Duration).inSeconds.toDouble(), 
                                onChanged:widget.sliderChange );
        
                
              }
              return const CircularProgressIndicator();
                
            }
          ),
          ) ,
           Expanded(flex:2 , 

          child: Row(crossAxisAlignment:CrossAxisAlignment.start, children: [
                      Expanded(flex:1 , child: Container()),
            Expanded(flex:7 , child: TextButton(style:buttonStyleAppBar ,   onPressed: () async{
                    await widget.pressPausePlay(stop:true);           
                    TrackSpot track = widget.pressPrev();
                     await track.SaveFile(); 
                     await track.loadSong(); 
                            setState(() {
                       widget.__init(track);
                     });
                     widget.pressPausePlay(play:true );
                     } ,child: const Icon(Icons.skip_previous , size : 20 ,color: color_pallet.spotifySecondry),),),
            Expanded(flex:1 , child: Container()),
            Expanded(flex:5 , child:StreamBuilder<Object>(
            stream: widget.state,
            builder: (context, snapshot) {
              if(snapshot.data != null ){
                  return ElevatedButton(
          child:  Icon((snapshot.data as bool) ? Icons.pause_circle_filled_outlined :  Icons.play_circle_fill_outlined   , 
                      size : 24 ,color: color_pallet.spotifySecondry),
         onPressed: widget.pressPausePlay,
          style: ElevatedButton.styleFrom(
              
              shape: const CircleBorder(), 
              
          ).merge(buttonStyleAppBar),
);
                
              }
              return const CircularProgressIndicator();
                
            }
          ), ),
                      Expanded(flex:1 , child: Container()),
            Expanded(flex:7 , child: TextButton(style:buttonStyleAppBar,   onPressed:  () async{ 
              await widget.pressPausePlay(stop:true);
              TrackSpot trackCurrent = widget.pressCurrent(); 
              trackCurrent.realse();
              TrackSpot trackNext = widget.pressNext();
                     await trackNext.SaveFile(); 
                     await trackNext.loadSong(); 
                      await widget.__init(trackNext);
                            setState(() {
               
                     });
                     widget.pressPausePlay(play: true); 
                     } ,child:  const Icon(Icons.skip_next , size : 20 , color: color_pallet.spotifySecondry, ),),),
                      Expanded(flex:1 , child: Container()),

            
            
            
            
            
            ],),
        ) 
          ],),
      ) ,









    );
  }
}