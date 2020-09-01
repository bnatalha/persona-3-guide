import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p3_guide/src/bloc/bloc.dart';
import 'package:p3_guide/src/service_locator.dart';
import 'package:p3_guide/src/ui/components/main_drawer.dart';
import 'package:p3_guide/src/ui/screens/social_link_detail/social_link_detail.dart';

class SocialLinkList extends StatefulWidget {
  static const String namedRoute = "/social-link-list";
  @override
  _SocialLinkListState createState() => _SocialLinkListState();
}

class _SocialLinkListState extends State<SocialLinkList> {
  final bloc = serviceLocator.get<SocialLinkBloc>();
  
  @override
  void initState() {
    bloc.add(SocialLinkFetch());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: MainDrawer(),
        drawerEdgeDragWidth: 40,
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
                  decoration: BoxDecoration(boxShadow: kElevationToShadow[12]),
                  padding: const EdgeInsets.all(4),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: .71,
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
