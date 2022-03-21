import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body:Container(color:Colors.amber,child: Center(child: const AutoSizeText("Error",minFontSize:30,maxLines: 1,)))
    );
  }
}