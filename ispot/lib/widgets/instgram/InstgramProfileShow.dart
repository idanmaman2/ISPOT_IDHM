import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:insta_dart/insta_dart.dart';
import 'package:ispot/widgets/instgram/providers/instgram_profile_show_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart' as spotify;

import '../../design/color.dart' as colorpallet;

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
      child: _ProfileShow(insta),
    );
  }
}

class _ProfileShow extends StatelessWidget {
  final InstaObject insta;
  _ProfileShow(this.insta);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorpallet.instagramMain,
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 1))),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: AutoSizeText(
                        insta.formatedName,
                        maxLines: 1,
                        minFontSize: 25,
                        maxFontSize: 40,
                        style: const TextStyle(fontFamily: 'NickName'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: CircleAvatar(
                                child: ClipOval(
                                  child: Image.network(insta.userPhotoLink),
                                ),
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          children: [
                                            const Expanded(
                                              child: AutoSizeText(
                                                "Biography:",
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 36, 36, 36),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: SingleChildScrollView(
                                                child: AutoSizeText(
                                                  insta.formatedBio,
                                                  maxFontSize: 25,
                                                  minFontSize: 14,
                                                  maxLines: 100,
                                                  style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 36, 36, 36),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Expanded(
                                          flex: 1,
                                          child: Text(
                                            "Followers: ${insta.formatedFollowers}",
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            flex: 152,
          ),
          Expanded(
            flex: 442,
            child: Container(
              constraints: const BoxConstraints.expand(),
              child: ListView.builder(
                  padding: const EdgeInsets.all(0.0),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: insta.items.length ~/ 3,
                  itemBuilder: (BuildContext context, int i) {
                    return SizedBox(
                        height: MediaQuery.of(context).size.height *
                            (3 / 4) *
                            (1 / 4),
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.pink, border: Border.all()),
                                  constraints: const BoxConstraints.expand(),
                                  child: (((i) * 3) < insta.items.length
                                      ? Provider.of<
                                                  InstgramProfileShowProvider>(
                                              context,
                                              listen: false)
                                          .creator(
                                          context,
                                          insta.items[i * 3],
                                        )
                                      : Container())),
                            ),
                            Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.blueGrey,
                                        border: Border.all()),
                                    constraints: const BoxConstraints.expand(),
                                    child: (((i) * 3 + 1) < insta.items.length
                                        ? Provider.of<
                                                    InstgramProfileShowProvider>(
                                                context,
                                                listen: false)
                                            .creator(
                                                context, insta.items[i * 3 + 1])
                                        : Container()))),
                            Expanded(
                                child: Container(
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    constraints: const BoxConstraints.expand(),
                                    child: (((i) * 3 + 2) < insta.items.length
                                        ? Provider.of<
                                                    InstgramProfileShowProvider>(
                                                context,
                                                listen: false)
                                            .creator(
                                                context, insta.items[i * 3 + 2])
                                        : Container())))
                          ],
                        ));
                  }),
            ),
          ),
        ],
      ),
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
              fit: BoxFit.fill,
              child: x,
            ),
          ),
        ));
  }
}
