import 'package:p3_guide/src/data/social_links_provider.dart';
import 'package:p3_guide/src/models/social_link_model.dart';

class Repository {
  final socialLinksProvider = SocialLinksProvider();

  Future<List<SocialLinkModel>> fetchAllSocialLinks() async {
    return socialLinksProvider.fetchSocialLinks();
  }

  List<String> fetchSocialLinksKeys() {
    return socialLinksProvider.arcanas;
  }
}