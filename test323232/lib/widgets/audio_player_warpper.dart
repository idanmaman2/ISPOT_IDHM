import 'package:flutter/material.dart';

class MusicPlayerWarpper extends StatefulWidget {
  final  Widget warp ;
  final void Function() pressNext;
  final void Function() pressPrev;
  final void Function() pressPausePlay;
  final double maxValueSecs ;
  final Stream<Duration> pos ;
  MusicPlayerWarpper({
    Key? key,
    required this.warp, 
    required this.pressNext ,
    required this.pressPrev , 
    required this.pressPausePlay ,
    required this.maxValueSecs, 
    required this.pos
                                }) : super(key: key);

  @override
  State<MusicPlayerWarpper> createState() => _MusicPlayerWarpperState();
}

class _MusicPlayerWarpperState extends State<MusicPlayerWarpper> {
    void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
    int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : Column ( children: [ 
        Expanded(
          child: widget.warp,flex:20),
      
      
      Expanded(flex:1 ,
      child: Container(
        child:StreamBuilder<Object>(
          stream: widget.pos,
          builder: (context, snapshot) {
            if(snapshot.data != null ){
                return Slider(min:0 , max: widget.maxValueSecs, value: (snapshot.data as Duration).inSeconds.toDouble(), onChanged: (x){} );
               print(snapshot.data.toString());
            }
            return const CircularProgressIndicator();
              
          }
        ),
        color: Colors.grey,constraints: const BoxConstraints.expand(),)) ,
         Expanded(flex:2 ,
      child: Row(children: [
        Expanded(flex:1 , child: TextButton(onPressed: (){





        },child: Icon(Icons.skip_previous),),),
        Expanded(flex:1 , child: TextButton(onPressed: (){






        },child: Icon(Icons.play_circle_fill_outlined),),),
        Expanded(flex:1 , child: TextButton(onPressed: widget.pressPausePlay ,child: Icon(Icons.skip_next),),),

        
        
        
        
        
        
        ],))
        ],) ,









    );
  }
}