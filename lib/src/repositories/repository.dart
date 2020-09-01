import 'package:p3_guide/src/models/quiz_answer_model.dart';
import 'package:p3_guide/src/models/social_link_model.dart';
import 'package:p3_guide/src/repositories/quiz_provider.dart';
import 'package:p3_guide/src/repositories/social_links_provider.dart';

class Repository {
  final socialLinksProvider = SocialLinksProvider();
  final quizProvider = QuizProvider();

  Future<List<SocialLinkModel>> fetchAllSocialLinks() async {
    return socialLinksProvider.fetchSocialLinks();
  }

  List<String> fetchSocialLinksKeys() {
    return socialLinksProvider.arcanas;
  }

  Future<List<QuizAnswerBlock>> fetchAllQuizAnswerBlocks() async {
    return quizProvider.fetchQuizAnswerBlocks();
  }
}