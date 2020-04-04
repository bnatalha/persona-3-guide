import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:p3_guide/src/models/social_link_model.dart';
// import 'package:p3_guide/src/models/social_link_model.dart';

class SocialLinkDetail extends StatefulWidget {
  @override
  _SocialLinkDetailState createState() => _SocialLinkDetailState();
}

class _SocialLinkDetailState extends State<SocialLinkDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () {
        Navigator.pop(context);
      },),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Hero(
              tag: "sl_0",
              child: Image.asset(
                "assets/images/social_links/fool.jpg",
                fit: BoxFit.cover,
                height: 300,
              ),
            ),
            FutureBuilder<String>(
              future: DefaultAssetBundle.of(context)
                  .loadString("assets/json/social_links/fool.json"),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    SocialLinkModel.fromJson(
                      json.decode(snapshot.data),
                    ).arcana,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                } else if (snapshot.hasError) {
                  Text(
                    "error",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return Text("text");
              },
            ),
          ],
        ),
      ),
    );
  }
}
