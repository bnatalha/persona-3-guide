import 'package:flutter/material.dart';

class TabbedInfo extends StatefulWidget {
  final String descriptionText;
  final String unlockText;
  final Color bgColor;
  final Color activeColor;

  const TabbedInfo({
    Key key,
    this.descriptionText,
    this.unlockText,
    this.bgColor,
    this.activeColor,
  }) : super(key: key);

  @override
  _TabbedInfoState createState() => _TabbedInfoState();
}

class _TabbedInfoState extends State<TabbedInfo>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: widget.bgColor,
          ),
          child: TabBar(
            indicator: BoxDecoration(
              color: widget.activeColor,
            ),
            controller: _controller,
            tabs: <Widget>[
              Tab(
                  child: buildTabButton(
                      iconData: Icons.description, text: "Info")),
              Tab(
                  child: buildTabButton(
                      iconData: Icons.card_giftcard, text: "Reward")),
            ],
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            color: widget.activeColor,
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                buildTabBarViewText(widget.descriptionText),
                buildTabBarViewText(widget.unlockText),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildTabBarViewText(String text) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(text, textAlign: TextAlign.justify),
    );
  }

  Widget buildTabButton({IconData iconData, String text}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          iconData,
        ),
        VerticalDivider(width: 8),
        Text(text, style: TextStyle(shadows: kElevationToShadow[3])),
      ],
    );
  }
}