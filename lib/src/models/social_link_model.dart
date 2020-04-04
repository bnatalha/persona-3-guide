import 'package:json_annotation/json_annotation.dart';

part "social_link_model.g.dart";

@JsonSerializable()
class SocialLinkModel {
  final String arcana;
  final String name;
  final String description;
  final List<String> ranks;
  final String unlocks;

  const SocialLinkModel({
    this.arcana,
    this.name,
    this.description,
    this.ranks,
    this.unlocks,
  });

  factory SocialLinkModel.fromJson(Map<String, dynamic> json) => _$SocialLinkModelFromJson(json);
  Map<String, dynamic> toJson() => _$SocialLinkModelToJson(this);
  
}