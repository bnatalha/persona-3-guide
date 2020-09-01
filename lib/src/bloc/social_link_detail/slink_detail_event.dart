import 'package:equatable/equatable.dart';

class RankIndexEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RankIndexEventNext extends RankIndexEvent {}

class RankIndexEventPrevious extends RankIndexEvent {}

class RankIndexEventJumpTo extends RankIndexEvent {
  final int newIndex;

  RankIndexEventJumpTo(this.newIndex) : assert(newIndex >= 0);
}
