import 'package:insta_dart/insta_dart.dart';

void main() async {
  InstgramOperator op = InstgramOperator(null, null); 
    print(await op.findInstaName("anna zack"));
    print((await op.getInstgram("annazak12")).bio);
}
