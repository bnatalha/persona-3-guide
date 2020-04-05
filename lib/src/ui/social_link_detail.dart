import 'package:flutter/material.dart';
import 'package:p3_guide/src/models/social_link_model.dart';

class SocialLinkDetail extends StatefulWidget {
  final SocialLinkModel socialLink;
  final String assetKey;
  final String heroTag;

  const SocialLinkDetail({
    Key key,
    this.socialLink,
    this.assetKey,
    this.heroTag,
  }) : super(key: key);

  @override
  _SocialLinkDetailState createState() => _SocialLinkDetailState();
}

class _SocialLinkDetailState extends State<SocialLinkDetail> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
        body: SingleChildScrollView(
          child: Container(
            height: mq.size.height - mq.padding.top,
            decoration: BoxDecoration(
              color: Colors.white10,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 270,
                        width: 300,
                        color: Theme.of(context).primaryColor.withOpacity(0.2),
                        alignment: Alignment.topRight,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: buildArcanaCard(),
                          ),
                          Expanded(
                            child: buildBasicInfoColumn(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    // color: Colors.black,
                    padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 250,
                          child: TabbedInfo(
                            descriptionText: widget.socialLink.description,
                            unlockText: widget.socialLink.unlocks,
                          ),
                        ),
                        buildRankContainer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextStyle buildTextStyle({Color color, double size, FontWeight weight}) {
    return TextStyle(
      color: color ?? Colors.white.withOpacity(.8),
      fontSize: size ?? 18,
      fontWeight: weight ?? FontWeight.normal,
    );
  }

  Hero buildArcanaCard() {
    return Hero(
      tag: widget.heroTag,
      child: Container(
        child: Container(
          margin: const EdgeInsets.fromLTRB(8, 20, 8, 0),
          child: Opacity(
            opacity: 1,
            // opacity: 0.5,
            child: Image.asset(
              "assets/images/social_links/${widget.assetKey}.jpg",
              fit: BoxFit.contain,
              height: 250,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBasicInfoColumn() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.socialLink.arcana,
            style: buildTextStyle(size: 24, weight: FontWeight.bold),
          ),
          Text(
            widget.socialLink.name,
            style: buildTextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Container buildRankContainer() {
    return Container(
      height: 240,
      margin: EdgeInsets.all(10),
      alignment: Alignment.center,
      child: ListView.builder(
        itemCount: widget.socialLink.ranks.length,
        itemBuilder: (_, index) => Text(
          widget.socialLink.ranks[index],
          style: buildTextStyle(size: 18),
        ),
      ),
    );
  }
}

class TabbedInfo extends StatefulWidget {
  final String descriptionText;
  final String unlockText;

  const TabbedInfo({Key key, this.descriptionText, this.unlockText})
      : super(key: key);

  @override
  _TabbedInfoState createState() => _TabbedInfoState();
}

class _TabbedInfoState extends State<TabbedInfo>
    with SingleTickerProviderStateMixin {
  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, initialIndex: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: TabBar(
            indicator: BoxDecoration(
              color: Colors.blue.shade300.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            controller: _controller,
            tabs: <Widget>[
              Tab(child: buildTabButton(iconData: Icons.description, text: "Description")),
              Tab(child: buildTabButton(iconData: Icons.lock_open, text: "Persona")),
            ],
          ),
        ),
        Expanded(
          child: InfoContainer(
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                Text(
                  widget.descriptionText,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.white54, fontSize: 14),
                ),
                Text(
                  widget.unlockText,
                  textAlign: TextAlign.justify,
                  style: TextStyle(color: Colors.white54, fontSize: 18),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildTabButton({IconData iconData, String text}) {
    final whiteColor = Colors.white60;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(iconData, color: whiteColor),
        VerticalDivider(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 14, color: whiteColor),
        )
      ],
    );
  }
}

class InfoContainer extends StatelessWidget {
  final Widget child;

  const InfoContainer({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: child,
    );
  }
}
