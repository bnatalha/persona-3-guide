import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:p3_guide/src/models/social_link_model.dart';

class SocialLinksProvider {
  List<SocialLinkModel> _socialLinks = [];

  static const String _jsonsPath = "assets/json/social_links/";
  static const List<String> _arcanas = [
    "aeon",
    "chariot",
    "death",
    "devil",
    "emperor",
    "empress",
    "fool",
    "fortune",
    "hangedman",
    "hermit",
    "hierophant",
    "judegment",
    "justice",
    "lovers",
    "magician",
    "moon",
    "priestess",
    "star",
    "strength",
    "sun",
    "temperance",
    "tower",
  ];

  SocialLinksProvider();

  Future<List<SocialLinkModel>> fetchSocialLinks() async {
    if (_socialLinks.isEmpty) {
      final List<SocialLinkModel> temp = [];
      for (String arcana in _arcanas) {
        final str = await rootBundle.loadString("$_jsonsPath$arcana.json");
        final sl = SocialLinkModel.fromJson(json.decode(str));
        temp.add(sl);
      }
      _socialLinks = temp;
    }
    return _socialLinks;
  }

  List<String> get arcanas => [..._arcanas];
}
