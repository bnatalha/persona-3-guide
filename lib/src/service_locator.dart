import 'package:get_it/get_it.dart';

import 'bloc/bloc.dart';

final serviceLocator = GetIt.instance;

setUpServiceLocator() {
  serviceLocator.registerSingleton(QuizAnswerBloc());
  serviceLocator.registerSingleton(SocialLinkBloc());
}
