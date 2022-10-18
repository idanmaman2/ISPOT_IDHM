import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:insta_dart/insta_dart.dart';
import 'package:ispot/widgets/instgram/providers/instgram_profile_show_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as spotify;

import '../../design/color.dart' as colorpallet;
import '../../design/color.dart';
import 'artist_show.dart';

class ProfileShow extends StatelessWidget {
  const ProfileShow(this.insta, {Key? key}) : super(key: key);

  final InstaObject insta;
  
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //                                     <--- MultiProvider
      providers: [
        ChangeNotifierProvider<InstgramProfileShowProvider>(
            create: (context) => InstgramProfileShowProvider()),
      ],
      child: _ProfileShow(insta,context),
    );
  }
}

class _ProfileShow extends StatelessWidget {
  final InstaObject insta;
    final  List<Widget> widList ;
  _ProfileShow(this.insta , context ):widList=[
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(child: Center(child: Text("Followers:${insta.formatedFollowers}"))),
        Expanded(
          child: SizedBox(child:
          GestureDetector(
            onTap: (){
        Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => ArtistShow(insta.profileName)),
      );
      },

  
            child: CircleAvatar(
                        child: ClipOval(
                        child: Image.network(insta.userPhotoLink),
                                    ),
                                  ),
          ),
                                height: 100,
                                width: 100,
                              ),
        ),
                            


      ],


    ),
      
      Text("Bio:${insta.bio}",style: TextStyle(fontSize: 20),)



  ];


      
  



  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
  slivers: <Widget>[
     SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 50.0,
      flexibleSpace: FlexibleSpaceBar(
        title:Text(insta.formatedName)
      ),
    ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return widList[index];
              },
              childCount: widList.length,
            ),
          ),
    SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        mainAxisSpacing: 1,
        crossAxisSpacing:1,
        childAspectRatio: 2/3,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) =>  Provider.of<InstgramProfileShowProvider>(context, listen: false).creator(context, insta.items[index]),
        childCount: insta.items.length,
      ),
    ),

  ],
);
  }
}

     
        

class PhotoShow extends StatelessWidget {
  final Image x;
  const PhotoShow({Key? key, required Image x})
      : x = x,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: colorpallet.instgramText,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: colorpallet.instagramMain,
                  ))
            ],
          ),
        ),
        body: Center(
          child: InteractiveViewer(
            child: FittedBox(
              fit:BoxFit.fill,
              child: x,
            ),
          ),
        ));
  }
}
