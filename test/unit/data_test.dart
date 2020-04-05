import 'package:flutter_test/flutter_test.dart';
import 'package:p3_guide/src/data/social_links_provider.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final expectedFirstArcana = "Aeon";
  final expectedSocialLinksSize = 22;
  test('teste SocialLinksProvider', () async {
    var slp = SocialLinksProvider();
    var list = await slp.fetchSocialLinks();
    expect(list[0].arcana, expectedFirstArcana);
    expect(list.length, expectedSocialLinksSize);
  });
}
