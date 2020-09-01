import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:p3_guide/src/models/quiz_answer_model.dart';

class QuizAnswerState extends Equatable {
  const QuizAnswerState();

  @override
  List<Object> get props => [];
}

class QuizAnswerStateUnitialized extends QuizAnswerState {}

class QuizAnswerStateError extends QuizAnswerState {
  final String msg;

  QuizAnswerStateError({@required this.msg});

  @override
  List<Object> get props => [msg];
}

class QuizAnswerStateLoaded extends QuizAnswerState {
  final List<QuizAnswerBlock> quizBlocks;

  QuizAnswerStateLoaded({@required this.quizBlocks});

  QuizAnswerModel getQuizAnswerModel(int qbIndex, qaIndex) =>
      quizBlocks[qbIndex].quizList[qaIndex];

  @override
  List<Object> get props => [quizBlocks];
}
