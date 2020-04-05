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
                    // padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                    // margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 20),
                          child: RankView(ranks: widget.socialLink.ranks),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 0, 8, 4),
                          margin: EdgeInsets.only(top: 10),
                          height: 220,
                          child: TabbedInfo(
                            descriptionText: widget.socialLink.description,
                            unlockText: widget.socialLink.unlocks,
                          ),
                        ),
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
}

class RankView extends StatefulWidget {
  final List<String> ranks;

  const RankView({Key key, @required this.ranks}) : super(key: key);

  @override
  _RankViewState createState() => _RankViewState();
}

class _RankViewState extends State<RankView> {
  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final itemExtent = mq.size.width;

    return Container(
      height: 170,
      color: Colors.black,
      // margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.centerLeft,
              // color: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Text(
                "Ranks".toUpperCase(),
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(
              children: <Widget>[
                ListView.builder(
                  itemExtent: itemExtent,
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.ranks.length,
                  itemBuilder: (_, index) => Container(
                    // width: mq.size.width,
                    width: double.infinity,
                    // width: 100,
                    padding: const EdgeInsets.all(8),
                    color: Colors.blue.shade200.withOpacity(0.4),
                    // height: 50,
                    alignment: Alignment.center,
                    child: Text(widget.ranks[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white60, fontSize: 18)),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    buildScrollButton(isLeft: true, itemExtent: itemExtent),
                    buildScrollButton(itemExtent: itemExtent),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _scrollLeft(double itemExtent) {
    _controller.animateTo(_controller.offset - itemExtent,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  _scrollRight(double itemExtent) {
    _controller.animateTo(_controller.offset + itemExtent,
        duration: Duration(milliseconds: 500), curve: Curves.ease);
  }

  Container buildScrollButton({bool isLeft, @required double itemExtent}) {
    isLeft = isLeft ?? false;
    return Container(
      alignment: isLeft ? Alignment.centerLeft : Alignment.centerRight,
      width: 100,
      child: Opacity(
        opacity: 0.15,
        child: Container(
          decoration: BoxDecoration(
              // shape: BoxShape.circle,
              color: Colors.black),
          height: double.infinity,
          child: IconButton(
              splashColor: Colors.transparent,
              enableFeedback: false,
              icon: Icon(
                isLeft ? Icons.arrow_back : Icons.arrow_forward,
                size: 24,
                color: Colors.white,
              ),
              onPressed: () {
                if (isLeft) {
                  _scrollLeft(itemExtent);
                } else {
                  _scrollRight(itemExtent);
                }
              }),
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
    _controller = TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          // padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            // color: Colors.black,
            color: Colors.blue.shade400.withOpacity(0.2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: TabBar(
            indicator: BoxDecoration(
              color: Colors.black,
              // color: Colors.blue.shade300.withOpacity(0.3),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
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
          child: InfoContainer(
            bgcolor: Colors.black,
            child: TabBarView(
              controller: _controller,
              children: <Widget>[
                buildTabBarViewText(text: widget.descriptionText, size: 16),
                buildTabBarViewText(text: widget.unlockText, size: 16),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildTabBarViewText({String text, double size}) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white54, fontSize: size),
      ),
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
  final Color bgcolor;

  const InfoContainer({Key key, this.bgcolor, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: bgcolor ?? Colors.white24,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: child,
    );
  }
}
