import 'dart:math';

import 'package:flutter/material.dart';
import 'package:p3_guide/src/ui/screens/questinoaries.dart';
import 'package:p3_guide/src/ui/screens/social_link_list.dart';
import 'package:p3_guide/src/utils/text_theme_utils.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: Drawer(
        elevation: 0,
        child: Container(
          // color: Theme.of(context).primaryColor,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              // Expanded(
              //   child: Container(
              //     height: 200,
              //     color: Colors.transparent,
              //   ),
              // ),
              buildMenuItem(
                context: context,
                iconData: Icons.link,
                rotate: true,
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(SocialLinkList.namedRoute);
                },
                title: "SOCIAL LINKS",
              ),
              buildDivider(),
              buildMenuItem(
                context: context,
                iconData: Icons.school,
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context)
                      .pushReplacementNamed(QuestionariesScreen.namedRoute);
                },
                title: "QUESTIONARIES",
              ),
              // buildDivider(),
              // buildMenuItem(
              //   context: context,
              //   rotate: true,
              //   iconData: Icons.star_border,
              //   onTap: () {},
              //   title: "QUESTS",
              // ),
              // buildDivider(),
              // buildMenuItem(
              //   context: context,
              //   rotate: true,
              //   iconData: Icons.card_giftcard,
              //   onTap: () {},
              //   title: "QUESTS",
              // ),
              // Expanded(
              //   child: Container(
              //     color: Colors.black,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: double.infinity,
      height: 4,
      // color: Colors.blue,
    );
  }

  Container buildMenuItem(
      {BuildContext context,
      Function onTap,
      IconData iconData,
      String title,
      bool rotate = false}) {
    return Container(
      height: 70,
      width: 250,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: InkResponse(
        onTap: onTap,
        enableFeedback: true,
        splashColor: Colors.amberAccent,
        child: Stack(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 10),
              child: ClipRect(
                child: Transform.rotate(
                  child: Icon(
                    iconData,
                    size: 40,
                    // size: 70,
                    color: Theme.of(context).accentColor.withOpacity(0.6),
                  ),
                  angle: rotate ? pi / 4 : 0,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(title, style: TextThemeUtils.LIGHT_MENU_TEXT),
            ),
          ],
        ),
      ),
    );
  }
}
