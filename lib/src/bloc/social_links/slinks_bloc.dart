import 'package:bloc/bloc.dart';
import 'package:p3_guide/src/bloc/social_links/slinks_event.dart';
import 'package:p3_guide/src/bloc/social_links/slinks_state.dart';
import 'package:p3_guide/src/models/social_link_model.dart';
import 'package:p3_guide/src/repositories/repository.dart';

export 'package:p3_guide/src/bloc/social_links/slinks_state.dart';
export 'package:p3_guide/src/bloc/social_links/slinks_event.dart';

class SocialLinkBloc extends Bloc<SocialLinkEvent, SocialLinkState> {
  final Repository _repository = Repository();
  @override
  SocialLinkState get initialState => SocialLinkUninitialized();

  @override
  Stream<SocialLinkState> mapEventToState(SocialLinkEvent event) async* {
    try {
      if (state is SocialLinkUninitialized) {
        final socialLinks = await _fetchSocialLinks();
        final keys = _fetchSocialLinksKeys();
        yield SocialLinkLoaded(socialLinks: socialLinks, keys: keys);
      }
    } catch (e) {
      yield SocialLinkError(msg: e.toString());
    }
  }

  Future<List<SocialLinkModel>> _fetchSocialLinks() {
    return _repository.fetchAllSocialLinks();
  }

  List<String> _fetchSocialLinksKeys() {
    return _repository.fetchSocialLinksKeys();
  }
}

// final bloc = SocialLinkBloc();
