import 'package:flutter/material.dart';
import 'package:ispot/design/color.dart';
import 'package:ispot/widgets/instgram/instgram_connection.dart';



void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const  MyApp({Key? key}) : super(key: key);
static const  Map<int, Color> color =
{
50:Color.fromRGBO(30,215,96, .1),
100:Color.fromRGBO(30,215,96, .2),
200:Color.fromRGBO(30,215,96, .3),
300:Color.fromRGBO(30,215,96, .4),
400:Color.fromRGBO(30,215,96, .5),
500:Color.fromRGBO(30,215,96, .6),
600:Color.fromRGBO(30,215,96, .7),
700:Color.fromRGBO(30,215,96, .8),
800:Color.fromRGBO(30,215,96, .9),
900:Color.fromRGBO(30,215,96, 1),
};
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ISPOT',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF01DB954, color)
,
        
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  @override
  Widget build(BuildContext context) {
    return const InstgramConnectionPage();
  }
}
