import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:p3_guide/src/models/quiz_answer_model.dart';

class QuizProvider {
  List<QuizAnswerBlock> _questionaries = [];

  // static const String _jsonsPath = "assets/json/questionary/questionary.json";
  static const String _jsonsPath = "assets/json/questionary/questionary.json";

  QuizProvider();

  Future<List<QuizAnswerBlock>> fetchQuizAnswerBlocks() async {
    if (_questionaries.isEmpty) {
      final str = await rootBundle.loadString("$_jsonsPath");
      final list = QuizAnswerBlockList.fromJson(json.decode(str));

      _questionaries = list.blocks;
    }
    return _questionaries;
  }
}
