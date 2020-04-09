import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p3_guide/src/bloc/bloc.dart';
import 'package:p3_guide/src/ui/social_link_detail.dart';

class SocialLinkList extends StatefulWidget {
  @override
  _SocialLinkListState createState() => _SocialLinkListState();
}

class _SocialLinkListState extends State<SocialLinkList> {
  @override
  void initState() {
    bloc.add(SocialLinkFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Social Links"),
        ),
        body: Center(
          child: BlocBuilder(
            bloc: bloc,
            builder: (ctx, state) {
              if (state is SocialLinkUninitialized) {
                return CircularProgressIndicator();
              }
              if (state is SocialLinkError) {
                return Text("Houve um erro: ${state.msg}");
              }
              if (state is SocialLinkLoaded) {
                final heroTagPref = "sl_";
                return Container(
                  padding: const EdgeInsets.all(4),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .7,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: state.socialLinks.length,
                    itemBuilder: (ctx, index) => InkResponse(
                      onTap: () {
                        print("tapped");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SocialLinkDetail(
                              socialLink: state.socialLinks[index],
                              heroTag: "$heroTagPref${state.keys[index]}",
                              assetKey: state.keys[index],
                            ),
                          ),
                        );
                      },
                      enableFeedback: true,
                      child: Hero(
                        tag: "$heroTagPref${state.keys[index]}",
                        child: Image.asset(
                          "assets/images/social_links/${state.keys[index]}.jpg",
                          fit: BoxFit.cover,
                          // height: 100,
                        ),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
