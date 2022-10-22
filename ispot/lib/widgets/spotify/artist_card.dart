


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ispot/design/color.dart';

class ArtistCard extends StatelessWidget {
 final  String _name ; 
final String _imageURl; 
final Color _bg ;  

final Color _fg; 
  final bool _round ; 
  final bool _dirHor; 

  const ArtistCard({ bool dirHor =false ,  required Color fg ,required String name , required String imageURL,required Color bg, bool round =false    ,  Key? key}) :_dirHor =dirHor  ,  _round=round , _fg = fg , _bg = bg , _imageURl = imageURL , _name = name ,  super(key: key);
  
  @override
  Widget build(BuildContext context) {
  List<Widget> childrenRowCol = [
     Spacer(flex:1 ),
                  Expanded(flex:_dirHor ?  14 : 10 , child: (!_round ? ClipRect (child: Image.network(_imageURl)): ClipOval(child: Image.network(_imageURl,fit: BoxFit.fitWidth,)))),
                  Spacer(flex:1 ),
                  Expanded(flex : _dirHor ? 4 : 8 , child: Align( alignment: !_dirHor ? Alignment.centerLeft : Alignment.bottomCenter ,child: Text(_name, style: TextStyle(fontSize:15 , fontWeight: FontWeight.w400,color: _bg),)))
                ] ; 
   return Card(
        
          child: 
          
          Container(
            color:_bg ,
            child: Container(
            
              decoration: BoxDecoration(
              boxShadow: [BoxShadow(spreadRadius: 0.4)],
                gradient: RadialGradient(colors:[_bg , _fg , _bg ,_fg],radius:0.6 , tileMode: TileMode.mirror),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                   color: _fg.withOpacity(0.80), 
                ),
                width:!_dirHor ?   200 : 150 ,
               
                child: !_dirHor ? Row(
                  children:childrenRowCol ,
                ): Column(children: childrenRowCol,), 
              ),
            ),
          ),
        );
         
      
    


  

  }

}

