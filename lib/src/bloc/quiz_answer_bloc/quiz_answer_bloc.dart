import 'package:bloc/bloc.dart';
import 'package:p3_guide/src/bloc/quiz_answer_bloc/quiz_answer_event.dart';
import 'package:p3_guide/src/bloc/quiz_answer_bloc/quiz_answer_state.dart';
import 'package:p3_guide/src/models/quiz_answer_model.dart';
import 'package:p3_guide/src/repositories/repository.dart';

export 'package:p3_guide/src/bloc/quiz_answer_bloc/quiz_answer_event.dart';
export 'package:p3_guide/src/bloc/quiz_answer_bloc/quiz_answer_state.dart';

class QuizAnswerBloc extends Bloc<QuizAnswerEvent, QuizAnswerState> {
  final _repository = Repository();

  @override
  QuizAnswerState get initialState => QuizAnswerStateUnitialized();

  @override
  Stream<QuizAnswerState> mapEventToState(QuizAnswerEvent event) async* {
    try {
      if (state is QuizAnswerStateUnitialized) {
        final quizBlockData = await _fetchQuizAnswerBlocks();
        yield QuizAnswerStateLoaded(quizBlocks: quizBlockData);
      }
    } catch (e) {
      yield QuizAnswerStateError(msg: e.toString());
    }
  }

  Future<List<QuizAnswerBlock>> _fetchQuizAnswerBlocks() {
    return _repository.fetchAllQuizAnswerBlocks();
  }
}
