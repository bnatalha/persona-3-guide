import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RankIndexState extends Equatable {
  final int currentIndex;

  const RankIndexState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}

class RankIndexStateError extends RankIndexState {
  final String msg;

  RankIndexStateError({@required this.msg}) : super(0);
}

class RankIndexStateUnintialized extends RankIndexState {
  const RankIndexStateUnintialized() : super(0);
}

class RankIndexStateUpdate extends RankIndexState {
  RankIndexStateUpdate(int newIndex) : super(newIndex);
}
