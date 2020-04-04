import 'package:flutter/material.dart';
import 'package:p3_guide/src/ui/social_link_list.dart';

class Persona3App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.yellow,
      ),
      title: "Persona 3 Guide",
      home: SocialLinkList(),
    );
  }
}
