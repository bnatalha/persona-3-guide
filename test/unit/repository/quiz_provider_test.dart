import 'package:flutter_test/flutter_test.dart';
import 'package:p3_guide/src/repositories/quiz_provider.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group("QuizProvider", () {

    test('has to fetch successfully', () async {
      final p = QuizProvider();
      final subject = await p.fetchQuizAnswerBlocks();

      expect(subject.isNotEmpty, true);
    });
  });
}
