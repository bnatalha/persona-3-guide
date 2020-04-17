import 'package:flutter_test/flutter_test.dart';
import 'package:p3_guide/src/repositories/quiz_provider.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("QuizAnswer", () {

    test('provider has to fetch', () async {
      final p = QuizProvider();
      final subject = await p.fetchQuizAnswerBlocks();

      expect(subject.isNotEmpty, true);
    });
  });
}
