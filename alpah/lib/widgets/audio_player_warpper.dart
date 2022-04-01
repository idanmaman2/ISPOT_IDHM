import 'package:flutter/material.dart';
import 'package:test323232/Decoration/colors.dart' as color_pallet;
import 'package:test323232/Objects/instgram_object.dart';
import 'package:test323232/Objects/total_pack.dart';
import 'package:test323232/Tools_Static/song_mannger.dart';
import 'package:test323232/Tools_Static/spot.dart';
import 'package:test323232/Objects/track_object.dart';
import 'package:test323232/widgets/instgram_page.dart';

import '../Tools_Static/youtube_ops.dart';
class MusicPlayerWarpper extends StatefulWidget {
  late ProfileShow warp ;
  late TrackSpot Function() pressNext;
  late TrackSpot Function() pressPrev;
    late TrackSpot Function() pressCurrent;
  late Future  Function({bool ? stop , bool ? play}) pressPausePlay;
  late void Function(double) sliderChange;
  late double maxValueSecs ;
  late Stream<Duration> pos ;
  late Stream<bool> state ;
  int sizeOfDisplay = 40 ; 
  int placeOfDisplay = 0 ;
  Stream<String> screen ; 
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
    required this.screen
    
                                }) : super(key: key);



    Future __init(TotalPack pack)async{
      warp = ProfileShow(
                          await YoutubeOps.getYoutubeId(pack.track!),
                          insta:(await pack.insta)!,
                          spot: spot.getSpotInstance(),
                        ); 
      maxValueSecs = pack.track!.durationOfSong().inSeconds.toDouble();
      pos = pack.track!.durationOfSongCurrent();
      pressNext = spot.getNextSong;
      pressPrev = spot.getPrevSong;
      pressCurrent = spot.getCurrentSong;
      sliderChange = (x){ pack.track!.seekSong(Duration(seconds: x.toInt()) );};
      pressPausePlay =pack.track!.pausePlayAuto;
      state = pack.track!.stateOfSongCurrent() ; 
      placeOfDisplay =0 ; 
      screen = (await pack.insta)!.StreamBio(5, 20);

    }

  @override
  State<MusicPlayerWarpper> createState() => _MusicPlayerWarpperState();
}

class _MusicPlayerWarpperState extends State<MusicPlayerWarpper> {
  
final ValueNotifier<String> _counter = ValueNotifier<String>("");

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
  void initState() {
    SongMannger.initSongMannger(sizeNext: 5, sizePrev: 5);
    super.initState();
    displayShow(200);
  }

  void  displayShow(int milisecs)async{

    await Future.delayed(Duration(milliseconds: milisecs));
      print("do that do that do that");



    String text = widget.warp.insta.bio.replaceAll("\n", " ").length == 0 ? "idan maman the king he is the real real real king and no one cares":(widget.warp.insta.bio.replaceAll("\n", " "));
    
    widget.placeOfDisplay = (widget.placeOfDisplay + 1  )%text.length ; 
    int sizeOfDisplay  = widget.sizeOfDisplay > text.length ? text.length : widget.sizeOfDisplay ; 
    if( (widget.placeOfDisplay+sizeOfDisplay)/text.length >1 ){  
      _counter.value = text.substring(widget.placeOfDisplay, text.length) + " " 
      + text.substring(0, (widget.placeOfDisplay + sizeOfDisplay - text.length )% (text.length)+1 );
    }
    else {
        _counter.value = text.substring(widget.placeOfDisplay, widget.placeOfDisplay+sizeOfDisplay);
    }
    

    displayShow(milisecs); 
    



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(automaticallyImplyLeading :false, backgroundColor: color_pallet.spotifySecondry,toolbarHeight: MediaQuery.of(context).size.height * 0.05 , 
      title:  Center(
        child: 
        StreamBuilder<Object>(
            stream: widget.screen,
            builder: (context, snapshot) {
              if(snapshot.data != null ){
                  return Text(snapshot.data as String ,style: TextStyle(fontFamily: "ScreenFont" ,color:color_pallet.spotifyMain),);

                
              }
              return const CircularProgressIndicator();
                
            }
          ),
        

      ), ),
      
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
                 
                  widget.pressPausePlay(stop:true).then((x)async{       await widget.pressPausePlay(stop:true);
              TotalPack pack = await SongMannger.getNextSong();
              await widget.__init(pack);
              setState(() {});
                     
                     
                     
                     
                     } );
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
           
        Expanded(
          flex:2 , 
          child: Row(crossAxisAlignment:CrossAxisAlignment.start, 
          children: [
            Expanded(flex:1 , child: Container()),

            Expanded(flex:7 , child: TextButton(style:buttonStyleAppBar ,   
                    onPressed: () async{
                    await widget.pressPausePlay(stop:true);           
                    TotalPack pack = SongMannger.getprevsong();
                            setState(() {
                       widget.__init(pack);
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
              TotalPack pack = await SongMannger.getNextSong();
              await widget.__init(pack);
              setState(() {});
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