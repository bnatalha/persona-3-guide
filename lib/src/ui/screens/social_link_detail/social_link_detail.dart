import 'package:flutter/material.dart';
import 'package:p3_guide/src/bloc/social_link_detail/slink_detail_bloc.dart';
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

    final arcanaCardBgBox = Container(
      margin: EdgeInsets.only(top: 10),
      height: 290,
      alignment: Alignment.centerLeft,
      width: mq.size.width * .75,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        boxShadow: kElevationToShadow[6],
      ),
    );

    final arcanaCard = Hero(
      tag: widget.heroTag,
      child: Container(
        height: 270,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(-16, 0),
            )
          ],
        ),
        margin: const EdgeInsets.fromLTRB(4, 20, 4, 15),
        child: Image.asset(
          "assets/images/social_links/${widget.assetKey}.jpg",
          fit: BoxFit.contain,
        ),
      ),
    );

    final basicInfoColumn = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          bottomLeft: Radius.circular(15),
        ),
        boxShadow: kElevationToShadow[6],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.socialLink.arcana,
            style: Theme.of(context).textTheme.title,
          ),
          Text(
            widget.socialLink.name,
            style: Theme.of(context).textTheme.subtitle,
          ),
        ],
      ),
    );

    final arcanaCardHeader = Stack(
      children: <Widget>[
        arcanaCardBgBox,
        Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(child: arcanaCard),
              VerticalDivider(
                width: mq.size.width * 0.02,
              ),
              Expanded(child: basicInfoColumn),
            ],
          ),
        ),
      ],
    );

    debugPrint("width: ${mq.size.width}");

    final socialLinkInfo = Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 20),
            child: RankView(bloc: SLinkDetailBloc(widget.socialLink.ranks, 0)),
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
    );

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
                  arcanaCardHeader,
                  socialLinkInfo,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
