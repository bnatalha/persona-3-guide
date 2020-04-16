import 'package:flutter/material.dart';

class QuestionariesScreen extends StatelessWidget {
  static const String namedRoute = "/questionary-answers";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (_, index) => ExpansionTile(
            children: <Widget>[
              Text("Answer 1"),
              Text("Answer 2"),
              Text("Answer 3"),
            ],
            title: Text("02/03/2009"),
          ),
        ),
      ),
    );
  }
}
