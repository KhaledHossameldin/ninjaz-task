// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostImpl _$$PostImplFromJson(Map<String, dynamic> json) => _$PostImpl(
      id: json['id'] as String,
      image: json['image'] as String,
      likes: json['likes'] as int,
      text: json['text'] as String,
      publishDate: DateTime.parse(json['publishDate'] as String),
      owner: Owner.fromJson(json['owner'] as Map<String, dynamic>),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$PostImplToJson(_$PostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'image': instance.image,
      'likes': instance.likes,
      'text': instance.text,
      'publishDate': instance.publishDate.toIso8601String(),
      'owner': instance.owner,
      'tags': instance.tags,
    };
