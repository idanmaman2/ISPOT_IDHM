import 'package:flutter/material.dart';
import 'package:ispot/widgets/spotify/providers/spotify_login_provider.dart';
import 'package:provider/provider.dart';
import 'package:spotify/spotify.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:ispot/objects/spotify/spot.dart';

import '../instgram/providers/providers_login.dart';

class SpotifyLogin extends StatelessWidget {
  const SpotifyLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //                                     <--- MultiProvider
      providers: [
        ChangeNotifierProvider<SpotifyLoginProvider>(
            create: (context) => SpotifyLoginProvider()),
      ],
      child: _SpotifyLogin(),
    );
  }
}

class _SpotifyLogin extends StatelessWidget {
  var keyJson;
  var keyMap;
  var credentials;
  var grant;
  final redirectUri = 'https://github.com/asimon655/dotNet5782_3715_6941';
  var authUri;
  final scopes = const [
    'user-library-read',
    'user-read-currently-playing',
    'user-read-recently-played',
    'playlist-read-private',
    'user-top-read'
  ];
  _SpotifyLogin() {
    credentials = SpotifyApiCredentials(
        "60b24b98a3be4b1c81eb513ff31671f4", "145a64b381d64bd4b9ce77d5e34bd1f6");
    grant = SpotifyApi.authorizationCodeGrant(credentials);
    authUri = grant.getAuthorizationUrl(
      Uri.parse(redirectUri),
      scopes: scopes, // scopes are optional
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future :  Provider.of<SpotifyLoginProvider>(context, listen: false).getGrant(), 

      builder:(context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.data == null ){
                    return Scaffold(
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: authUri.toString(),
          navigationDelegate: (navReq) {
            if (navReq.url.startsWith(redirectUri)) {
              Provider.of<SpotifyLoginProvider>(context, listen: false)
                  .LoadToken(grant, navReq);
              Provider.of<SpotifyLoginProvider>(context, listen: false)
                  .nextScreen(context);
              return NavigationDecision.prevent;
            }
    
            return NavigationDecision.navigate;
          },
        ),
      );
          }
          Provider.of<SpotifyLoginProvider>(context, listen: false).nextScreen(context);

        }
        return CircularProgressIndicator(); 

      }
    );
  }
  }

