import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:avatars/avatars.dart';
import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:test323232/InstgramObject.dart';
import 'package:test323232/Stringops.dart';
import 'package:test323232/photo_show.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class ProfileShow extends StatefulWidget {
  final InstaObject insta;
  spotify.SpotifyApi spot;
  late YoutubePlayerController _controller;
  ProfileShow(
    String youtubeid, {
    Key? key,
    required InstaObject insta,
    required spotify.SpotifyApi spot,
  })  : this.insta = insta,
        spot = spot,
        super(key: key) {
    _controller = YoutubePlayerController(
      initialVideoId: youtubeid,
      flags: YoutubePlayerFlags(autoPlay: false, mute: true, startAt: 0),
    );
  }
  @override
  State<ProfileShow> createState() => _ProfileShowState();
}

class _ProfileShowState extends State<ProfileShow> {
  Widget creator(String x) {
    Image img = Image.network(
      x,
      fit: BoxFit.fill,
    );
    return InkWell(
      child: img,
      onTap: () => Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
            builder: (BuildContext context) => PhotoShow(x: img)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 1))),
              child: Container(
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        child: Center(
                          child: AutoSizeText(
                            "@" + widget.insta.ProfileName,
                            maxLines: 1,
                            minFontSize: 25,
                            maxFontSize: 40,
                            style: const TextStyle(fontFamily: 'NickName'),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              child: Center(
                                child: Avatar(
                                    onTap: () async {
                                      Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                              builder: (BuildContext context) =>
                                                  Scaffold(
                                                      body: YoutubePlayer(
                                                    controller:
                                                        widget._controller,
                                                    showVideoProgressIndicator:
                                                        true,
                                                    onReady: () {},
                                                  ))));
                                      await Future.delayed(
                                          Duration(seconds: 3));
                                      var value = await widget.spot.me
                                          .currentlyPlaying();

                                      print(value.progress_ms);
                                      print("sekkkkkkkkkkkkkkkkkkkkkkk");

                                      widget._controller?.seekTo(
                                          Duration(
                                              seconds: 3 +
                                                  ((value.progress_ms as int) ~/
                                                      1000),
                                              microseconds: 600),
                                          allowSeekAhead: true);
                                      print(value.progress_ms);
                                    },
                                    sources: [
                                      NetworkSource(widget.insta.userPhotoLink)
                                    ],
                                    border: Border.all(
                                        color: Colors.black, width: 1)),
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: AutoSizeText(
                                            "Biography:\n${StringOPs.splitTosmall(widget.insta.Bio)}",
                                            maxFontSize: 25,
                                            minFontSize: 14,
                                            maxLines: 5,
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Text(
                                                "Followers: ${StringOPs.numberShow(widget.insta.Followers.toString())}"))
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            flex: 152,
          ),
          Expanded(
            flex: 442,
            child: Container(
              constraints: BoxConstraints.expand(),
              child: Container(
                child: ListView.builder(
                    padding: EdgeInsets.all(0.0),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: (widget.insta.items.length / 3).toInt(),
                    itemBuilder: (BuildContext context, int i) {
                      return Container(
                          height: MediaQuery.of(context).size.height *
                              (3 / 4) *
                              (1 / 4),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.pink,
                                        border: Border.all()),
                                    constraints: BoxConstraints.expand(),
                                    child:
                                        (((i) * 3) < widget.insta.items.length
                                            ? creator(
                                                widget.insta.items[i * 3],
                                              )
                                            : Container())),
                              ),
                              Expanded(
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey,
                                          border: Border.all()),
                                      constraints: BoxConstraints.expand(),
                                      child: (((i) * 3 + 1) <
                                              widget.insta.items.length
                                          ? creator(
                                              widget.insta.items[i * 3 + 1],
                                            )
                                          : Container()))),
                              Expanded(
                                  child: Container(
                                      decoration:
                                          BoxDecoration(border: Border.all()),
                                      constraints: BoxConstraints.expand(),
                                      child: (((i) * 3 + 2) <
                                              widget.insta.items.length
                                          ? creator(
                                              widget.insta.items[i * 3 + 2],
                                            )
                                          : Container())))
                            ],
                          ));
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
