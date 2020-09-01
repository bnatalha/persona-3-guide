import 'package:p3_guide/src/bloc/social_link_detail/slink_detail_event.dart';
import 'package:rxdart/rxdart.dart';

export 'package:p3_guide/src/bloc/social_link_detail/slink_detail_event.dart';
export 'package:p3_guide/src/bloc/social_link_detail/slink_detail_state.dart';

class SLinkDetailBloc {
  final List<String> _ranks;
  final rankCtrl = BehaviorSubject<RankIndexEvent>();

  double itemExtent;
  int currentIndex;

  // SLinkDetailBloc(this._ranks) {_rankCtrl.listen((data) => _scrollList(data));}
  SLinkDetailBloc(this._ranks, this.currentIndex) {
    rankCtrl.listen((data) {
      print(data);
    });
  }

  // _rank.
  void Function(RankIndexEvent) get pushIndexEvent => rankCtrl.sink.add;
  // void Function(Function) get rankCtrlListen => (_) => _rankCtrl.listen;

  List<String> get ranks => _ranks;

  // _scrollList(RankIndexEvent rankEvent, ScrollController controller) async {

  //   var offset = itemExtent;
  //   if (rankEvent is RankIndexEventPrevious) {
  //     offset = -offset;
  //   }

  //   controller.animateTo(offset, duration: Duration(milliseconds: 200), curve: null)

  //   // if (!(rankEvent is RankIndexEvent)) {
  //   //   await controller.animateTo(controller.offset + itemExtent,
  //   //       duration: _scrollDuration, curve: Curves.ease);
  //   // }
  // }

  dispose() {
    rankCtrl.close();
  }
}
