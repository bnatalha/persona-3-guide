import 'package:flutter/material.dart';
import 'package:p3_guide/src/ui/social_link_detail.dart';

class SocialLinkList extends StatefulWidget {
  @override
  _SocialLinkListState createState() => _SocialLinkListState();
}

class _SocialLinkListState extends State<SocialLinkList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Social Links"),
        ),
        body: Center(
          child: InkResponse(
            onTap: () {
              print("tapped");
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => SocialLinkDetail()));
            },
            enableFeedback: true,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Hero(
                  tag: "sl_0",
                  child: Image.asset(
                    "assets/images/social_links/fool.jpg",
                    fit: BoxFit.cover,
                    height: 200,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: Container(
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      // shape: BoxShape.circle,
                      color: Colors.white70,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "Fool",
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
