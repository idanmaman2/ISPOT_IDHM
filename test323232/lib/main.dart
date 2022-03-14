import 'dart:convert';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:spotify/spotify.dart';
import 'package:test323232/Objects/instgram_object.dart';
import 'package:test323232/widgets/instgram_page.dart';
import 'package:test323232/Tools_Static/spot.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart' as ytl;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "hi"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var keyJson;
  var keyMap;

  var credentials;
  var grant;

  var redirectUri = 'https://github.com/asimon655/dotNet5782_3715_6941';
  var authUri;
  final scopes = [
    'user-library-read',
    'user-read-currently-playing',
    'user-read-recently-played',
    'playlist-read-private',
    'user-top-read'
  ];
  _MyHomePageState() {
    credentials = SpotifyApiCredentials(
        "faacc54f879248a2b00b8d4acced093b", "5356a6e50a19497e84fa34b38136e1c4");
    grant = SpotifyApi.authorizationCodeGrant(credentials);
    authUri = grant.getAuthorizationUrl(
      Uri.parse(redirectUri),
      scopes: scopes, // scopes are optional
    );
  }
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: authUri.toString(),
        navigationDelegate: (navReq) {
          if (navReq.url.startsWith(redirectUri)) {
            print(navReq.url);

            final spotify = SpotifyApi.fromAuthCodeGrant(grant, navReq.url);

            print((spotify.me.currentlyPlaying()).then((x) async {
              print(x.item?.name);
              print(x.item?.artists?.first.name);
              String insatSearch;
              do {
                insatSearch = await http.read(Uri.parse(
                    "https://www.instagram.com/web/search/topsearch/?context=blended&query=${x.item?.artists?.first.name}&rank_token=0.3610197994284863&include_reel=true"));
                print(insatSearch);
              } while (insatSearch.contains("<!DOCTYPE html>"));

              var instaSearchJson = jsonDecode(insatSearch);
              print((instaSearchJson['users']).first['user']["username"]);

              final youtubeReg = RegExp('''\"videoId\"\:\"[\\w]{11}\"''');

              final youtubeCode = await http.read(Uri.parse(
                  "https://www.youtube.com/results?search_query=${x.item!.name!}"));
              String VideoId = youtubeCode
                  .substring(youtubeReg.allMatches(youtubeCode).first.start,
                      youtubeReg.allMatches(youtubeCode).first.end)
                  .substring(11, 22);
              print(VideoId);

              var yt = ytl.YoutubeExplode();
              var manifest2 = await yt.videos.streamsClient
                  .getManifest(ytl.VideoId(VideoId));
              var audio2 = manifest2.audioOnly.last;
              print(audio2.size);
              await Permission.storage.request();
              print(VideoId);
              var id = ytl.VideoId(VideoId);
              // Get the streams manifest and the audio track.
              var manifest = await yt.videos.streamsClient.getManifest(id);
              var audio = manifest.audioOnly.last;
              var video = await yt.videos.get(id);
              // Build the directory.
              Directory appDocumentsDirectory =
                  await getApplicationDocumentsDirectory(); // 1
              String appDocumentsPath = appDocumentsDirectory.path; // 2
              String filePath =
                  '$appDocumentsPath/${video.id}.${audio.container.name}'; // 3
              print(filePath);
              var file = File(filePath);
              var fileStream = file.openWrite();
              await yt.videos.streamsClient.get(audio).listen((event) {
                print("audio: " + event.join(""));
              });
              await yt.videos.streamsClient.get(audio).pipe(fileStream);
              await fileStream.flush();
              await fileStream.close();

              yt.close();
              AudioPlayer audioPlayer = AudioPlayer();
              await audioPlayer.play(filePath);
              print(youtubeCode.substring(
                  youtubeReg.allMatches(youtubeCode).first.start,
                  youtubeReg.allMatches(youtubeCode).first.end));
              String insta;
              do {
                insta = await http.read(Uri.parse(
                    "https://www.instagram.com/${(instaSearchJson['users']).first['user']["username"]}/?__a=1"));
              } while (insta.contains("<!DOCTYPE html>"));
              var instaJson = jsonDecode(insta);

              instaJson['graphql']['user']['edge_owner_to_timeline_media']
                      ['edges']
                  .forEach((element) {
                print(element);
              });

              List<String> links = [];

              (instaJson['graphql']['user']['edge_owner_to_timeline_media']
                      ['edges'])
                  .map((e) => e['node']['display_url'].toString())
                  .forEach((x) => links.add(x));

              print(links);
              InstaObject i = InstaObject(
                  links,
                  instaSearchJson['users'].first['user']["username"],
                  instaJson['graphql']['user']['biography'],
                  instaJson['graphql']['user']['profile_pic_url_hd'],
                  int.parse(instaJson['graphql']['user']["edge_followed_by"]
                          ["count"]
                      .toString()));
              print("hello");
              Navigator.push<void>(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => Scaffold(
                            body: ProfileShow(
                          VideoId,
                          insta: i,
                          spot: spotify,
                        ))),
              );
              DateTime dt = DateTime.now().subtract(Duration(hours: 1));
              var x1 = await spotify.me.recentlyPlayed(limit: 50, after: dt);

              x1.forEach((element) {
                print(element.track?.name);
              });
              var spoti = await spot.getLastSongs(spotify);
              print(spoti.length);
              spoti.forEach((element) {
                print(element.name! + element.id! + element.uri!);
              });
            }));

            return NavigationDecision.prevent;
          }

          return NavigationDecision.navigate;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
