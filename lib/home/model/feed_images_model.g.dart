// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_images_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedImage _$FeedImageFromJson(Map<String, dynamic> json) => FeedImage(
  profileImage: json['profileImage'] as String,
  nickname: json['nickname'] as String,
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  date: DateUtils.fromJsonDateTime(json['date'] as String),
);

Map<String, dynamic> _$FeedImageToJson(FeedImage instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'date': DateUtils.toJsonDateTime(instance.date),
  'profileImage': instance.profileImage,
  'nickname': instance.nickname,
};

FeedImagesResponse _$FeedImagesResponseFromJson(Map<String, dynamic> json) =>
    FeedImagesResponse(
      content:
          (json['content'] as List<dynamic>)
              .map((e) => FeedImage.fromJson(e as Map<String, dynamic>))
              .toList(),
      page: (json['page'] as num).toInt(),
      size: (json['size'] as num).toInt(),
      totalElements: (json['totalElements'] as num).toInt(),
      totalPages: (json['totalPages'] as num).toInt(),
      last: json['last'] as bool,
    );

Map<String, dynamic> _$FeedImagesResponseToJson(FeedImagesResponse instance) =>
    <String, dynamic>{
      'content': instance.content,
      'page': instance.page,
      'size': instance.size,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'last': instance.last,
    };
