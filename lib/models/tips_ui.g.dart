// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tips_ui.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TipUi _$TipUiFromJson(Map<String, dynamic> json) => TipUi(
      id: (json['id'] as num?)?.toInt(),
      text: json['text'] as String,
      author: json['author'] as String,
      upvotes: (json['upvotes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      downvotes: (json['downvotes'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$TipUiToJson(TipUi instance) => <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'author': instance.author,
      'upvotes': instance.upvotes,
      'downvotes': instance.downvotes,
    };
