import 'package:get_it/get_it.dart';

import 'bloc/bloc.dart';

final serviceLocator = GetIt.instance;

setUpServiceLocator() {
  serviceLocator.registerLazySingleton(() => QuizAnswerBloc());
  serviceLocator.registerLazySingleton(() => SocialLinkBloc());
  serviceLocator.registerFactoryParam<SLinkDetailBloc, List<String>, void>(
      (r, _) => SLinkDetailBloc(r, 0));
}
