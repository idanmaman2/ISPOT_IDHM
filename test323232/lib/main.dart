import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:spotify/spotify_browser.dart';
import 'package:test323232/InstgramObject.dart';
import 'package:test323232/instgramPage.dart';
import 'package:test323232/spot.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

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
    'user-read-email',
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
              var insatSearch = await http.read(Uri.parse(
                  "https://www.instagram.com/web/search/topsearch/?context=blended&query=${x.item?.artists?.first.name}&rank_token=0.3610197994284863&include_reel=true"));
              print(insatSearch);
              var instaSearchJson = jsonDecode(insatSearch);
              print((instaSearchJson['users']).first['user']["username"]);

              final youtubeReg = RegExp('''\"videoId\"\:\"[\\w]{11}\"''');

              final youtubeCode = await http.read(Uri.parse(
                  "https://www.youtube.com/results?search_query=${x.item!.name! + x.item!.artists!.join(" ")}"));
              String VideoId = youtubeCode
                  .substring(youtubeReg.allMatches(youtubeCode).first.start,
                      youtubeReg.allMatches(youtubeCode).first.end)
                  .substring(11, 22);
              print(VideoId);
              print(youtubeCode.substring(
                  youtubeReg.allMatches(youtubeCode).first.start,
                  youtubeReg.allMatches(youtubeCode).first.end));

              final insta = await http.read(Uri.parse(
                  "https://www.instagram.com/${(instaSearchJson['users']).first['user']["username"]}/?__a=1"));
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
