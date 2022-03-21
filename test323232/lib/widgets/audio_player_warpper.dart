import 'package:flutter/material.dart';

class MusicPlayerWarpper extends StatefulWidget {
  final  Widget warp ;
  const MusicPlayerWarpper({Key? key,required this.warp}) : super(key: key);

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
        color: Colors.amber,constraints: const BoxConstraints.expand(),)) ,
         Expanded(flex:2 ,
      child: Row(children: [
        Expanded(flex:1 , child: TextButton(onPressed: (){},child: Icon(Icons.skip_previous),),),
        Expanded(flex:1 , child: TextButton(onPressed: (){},child: Icon(Icons.play_circle_fill_outlined),),),
        Expanded(flex:1 , child: TextButton(onPressed: (){},child: Icon(Icons.skip_next),),),

        
        
        
        
        
        
        ],))
        ],) ,









    );
  }
}