import 'package:flutter/foundation.dart';

class QuizAnswerModel {
  final String occursOn;
  final List<String> answers;

  bool get isExam => answers.length > 1;

  QuizAnswerModel({
    @required this.occursOn,
    @required this.answers,
  });

  factory QuizAnswerModel.fromJson(Map<String, dynamic> json) {
    try {
      return QuizAnswerModel(
        occursOn: json['occursOn'] as String,
        answers: (json['answers'] as List)?.map((e) => e as String)?.toList(),
      );
    } catch (e) {
      throw Exception('QuizAnswerModel: ${e.toString()}');
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        'occursOn': this.occursOn,
        'answers': this.answers,
      };
    } catch (e) {
      throw Exception('QuizAnswerModel: ${e.toString()}');
    }
  }
}

class QuizAnswerBlock {
  final int monthNumber;
  final List<QuizAnswerModel> quizList;

  QuizAnswerBlock({
    @required this.monthNumber,
    @required this.quizList,
  });

  factory QuizAnswerBlock.fromJson(Map<String, dynamic> json) {
    try {
      return QuizAnswerBlock(
        monthNumber: json["monthNumber"] as int,
        quizList: (json["quizList"] as List)
            ?.map((e) => QuizAnswerModel.fromJson(e))
            ?.toList(),
      );
    } catch (e) {
      throw Exception('QuizAnswerBlock: ${e.toString()}');
    }
  }

  Map<String, dynamic> toJson() {
    try {
      return {
        "monthNumber": this.monthNumber,
        "quizList": this.quizList,
      };
    } catch (e) {
      throw Exception('QuizAnswerBlock: ${e.toString()}');
    }
  }
}

class QuizAnswerBlockList {
  final List<QuizAnswerBlock> blocks;

  QuizAnswerBlockList({
    this.blocks,
  });

  factory QuizAnswerBlockList.fromJson(List<dynamic> json) {
    try {
      return QuizAnswerBlockList(
        blocks: json?.map((e) => QuizAnswerBlock.fromJson(e))?.toList(),
      );
    } catch (e) {
      throw Exception('QuizAnswerBlockList: ${e.toString()}');
    }
  }

  List<Map<String, dynamic>> toJson() {
    try {
      return this.blocks.map((e) => e?.toJson())?.toList();
    } catch (e) {
      throw Exception('QuizAnswerBlockList: ${e.toString()}');
    }
  }
}
