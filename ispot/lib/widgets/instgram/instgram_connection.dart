import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ispot/widgets/instgram/providers/providers_login.dart';
import 'package:ispot/widgets/spotify/spotify_login.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:insta_dart/insta_dart.dart';
import '../../design/color.dart' as colorpallet;

class InstgramConnectionPage extends StatelessWidget {
  const InstgramConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //                                     <--- MultiProvider
      providers: [
        ChangeNotifierProvider<InstgramLoginProvider>(
            create: (context) => InstgramLoginProvider()),
      ],
      child: _InstgramConnectionPage(),
    );
  }
}

class _InstgramConnectionPage extends StatelessWidget {
  List<WebViewCookie> _coockilida = [];
  _InstgramConnectionPage({Key? key}) : super(key: key);
  static const String redirectUri = 'https://www.codegrepper.com/';
  static const String clientId = "341783747982324";
  static const clientSecret = "01e04f84464eda6eaf4bcc2451a2e61a";
  final scopes = const ['user_profile'];
  InstgramMannger insta = InstgramMannger(clientId, clientSecret, redirectUri,getApplicationDocumentsDirectory());
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future : insta.restoreCook(), 
      builder : (context,snapshot ){
          if(snapshot.connectionState == ConnectionState.done){
            if(snapshot.data == null ){
              return   Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () =>
                      Provider.of<InstgramLoginProvider>(context, listen: false)
                          .nextScreen(context),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: colorpallet.instgramText, width: 1.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: AutoSizeText(
                        "Skip",
                        minFontSize: 20,
                        maxFontSize: 40,
                        style: TextStyle(
                            color: colorpallet.instgramText,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ))
            ],
          ),
        ),
        body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: insta.getFullAdress(scopes),
          userAgent:
              "Mozilla/5.0 (Linux; Android 8.0.0; SM-G960F Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.84 Mobile Safari/537.36",
          navigationDelegate: (navReq) async {
            if (navReq.url.startsWith(redirectUri)) {
               Provider.of<InstgramLoginProvider>(context, listen: false)
                  .nextScreen(context, navReq: navReq, insta: insta);
    
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      );
            }
              Provider.of<InstgramLoginProvider>(context, listen: false)
                  .jumpToFuture(context);
             
            
          }
          return CircularProgressIndicator();





      }
     
    );
  }
}
