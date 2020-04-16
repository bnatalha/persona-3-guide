import 'package:flutter/material.dart';
import 'package:p3_guide/src/models/social_link_model.dart';
import 'package:p3_guide/src/ui/screens/social_link_detail/social_link_rank_view.dart';
import 'package:p3_guide/src/ui/screens/social_link_detail/social_link_tabbed_info_view.dart';

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
        body: SingleChildScrollView(
          child: Container(
            height: mq.size.height - mq.padding.top,
            decoration: BoxDecoration(),
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
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          boxShadow: kElevationToShadow[6],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: buildArcanaCard(context),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: buildBasicInfoColumn(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 20),
                          child: RankView(ranks: widget.socialLink.ranks),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          height: 220,
                          child: TabbedInfo(
                            descriptionText: widget.socialLink.description,
                            unlockText: widget.socialLink.unlocks,
                            bgColor: Theme.of(context).primaryColor,
                            activeColor: Colors.black,
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

  Hero buildArcanaCard(BuildContext context) {
    return Hero(
      tag: widget.heroTag,
      child: Container(
        child: Container(
          decoration: BoxDecoration(boxShadow: kElevationToShadow[3]),
          margin: const EdgeInsets.only(top: 20),
          padding: EdgeInsets.only(left: 10, top: 10, bottom: 5),
          child: Image.asset(
            "assets/images/social_links/${widget.assetKey}.jpg",
            fit: BoxFit.contain,
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
          boxShadow: kElevationToShadow[3]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(widget.socialLink.arcana,
              style: Theme.of(context).textTheme.title),
          Text(
            widget.socialLink.name,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ],
      ),
    );
  }
}