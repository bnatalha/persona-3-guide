import 'package:flutter_test/flutter_test.dart';
import 'package:p3_guide/src/repositories/social_links_provider.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SocialLinkProvider', () {
    final expectedFirstArcana = "Fool";
    final expectedSocialLinksSize = 22;

    test('has to fetch successfully', () async {
      final slp = SocialLinksProvider();
      final list = await slp.fetchSocialLinks();
      expect(list[0].arcana, expectedFirstArcana);
      expect(list.length, expectedSocialLinksSize);
    });
  });
}
