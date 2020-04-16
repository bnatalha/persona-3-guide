import 'package:flutter/material.dart';
import 'package:p3_guide/src/ui/screens/questinoaries.dart';
import 'package:p3_guide/src/ui/screens/social_link_list.dart';
import 'package:p3_guide/src/ui/screens/test.dart';

class Persona3App extends StatelessWidget {
  final dartTextTheme = ThemeData.dark().textTheme;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade900,
        // appBarTheme: AppBarTheme(
        // color: Theme.of(context).primaryColor.withOpacity(0.35),
        // ),
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue.shade900,
        accentColor: Colors.amberAccent,
        textTheme: dartTextTheme.copyWith(
          headline: dartTextTheme.headline.copyWith(
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
          title: dartTextTheme.title.copyWith(
            fontWeight: FontWeight.bold,
          ),
          subtitle: dartTextTheme.subtitle.copyWith(
            color: Colors.grey,
            fontStyle: FontStyle.italic,
          ),
          body2: dartTextTheme.body2.copyWith(
            fontSize: 18,
            fontStyle: FontStyle.italic,
          ),
          body1:
              dartTextTheme.body1.copyWith(fontSize: 18, color: Colors.white70),
        ),
      ),
      title: "Persona 3 Guide",
      routes: {
        QuestionariesScreen.namedRoute: (_) => QuestionariesScreen(),
        QuestionariesScreen.namedRoute: (_) => QuestionariesScreen(),
      },
      home: SocialLinkList(),
      // home: TestScreen(),
    );
  }
}
