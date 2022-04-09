import 'package:insta_dart/insta_dart.dart';

void main() async {
  print(await InstgramOperator.findInstaName("anna zack"));
  print((await InstgramOperator.getInstgram("annazak12")).bio);
}
