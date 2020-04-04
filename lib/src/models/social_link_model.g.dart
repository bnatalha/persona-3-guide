// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_link_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SocialLinkModel _$SocialLinkModelFromJson(Map<String, dynamic> json) {
  return SocialLinkModel(
    arcana: json['arcana'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    ranks: (json['ranks'] as List)?.map((e) => e as String)?.toList(),
    unlocks: json['unlocks'] as String,
  );
}

Map<String, dynamic> _$SocialLinkModelToJson(SocialLinkModel instance) =>
    <String, dynamic>{
      'arcana': instance.arcana,
      'name': instance.name,
      'description': instance.description,
      'ranks': instance.ranks,
      'unlocks': instance.unlocks,
    };
