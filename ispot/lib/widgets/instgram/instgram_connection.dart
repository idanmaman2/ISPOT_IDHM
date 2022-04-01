import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:insta_dart/insta_dart.dart';

class InstgramConnectionPage extends StatelessWidget {
  InstgramConnectionPage({Key? key}) : super(key: key);
  static const String  redirectUri = 'https://www.codegrepper.com/';
  static const  String  clientId = "341783747982324";
  static const clientSecret = "01e04f84464eda6eaf4bcc2451a2e61a";
  final scopes = const [
    'user_profile'
  ];
  InstgramMannger insta = InstgramMannger(clientId, clientSecret, redirectUri);
  @override
  Widget build(BuildContext context) {
    return WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:insta.getFullAdress(scopes) , 
        userAgent:"Mozilla/5.0 (Linux; Android 8.0.0; SM-G960F Build/R16NW) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.84 Mobile Safari/537.36",
        navigationDelegate: (navReq) async{
           if (navReq.url.startsWith(redirectUri)){  
          print(navReq);
          insta.code = navReq.url ; 
          InstgramOperator op = await insta.fromCode;
          print(await op.findInstaName("anna zack"));
          print((await op.getInstgram("annazak12")).bio);
           return NavigationDecision.prevent;
          }

          return NavigationDecision.navigate;
        },
      );
  }
}