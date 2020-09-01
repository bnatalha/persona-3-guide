import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:p3_guide/src/models/social_link_model.dart';

abstract class SocialLinkState extends Equatable {
  const SocialLinkState();
  @override
  List<Object> get props => [];
}

class SocialLinkUninitialized extends SocialLinkState {}

class SocialLinkError extends SocialLinkState {
  final String msg;

  const SocialLinkError({@required this.msg});

  @override
  List<Object> get props => [msg];
}

class SocialLinkLoaded extends SocialLinkState {
  final List<SocialLinkModel> socialLinks;
  final List<String> keys;

  const SocialLinkLoaded({
    @required this.socialLinks,
    @required this.keys,
  });

  @override
  List<Object> get props => [socialLinks, keys];
}
