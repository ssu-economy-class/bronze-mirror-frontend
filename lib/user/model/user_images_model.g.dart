// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_images_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserImage _$UserImageFromJson(Map<String, dynamic> json) => UserImage(
  id: (json['id'] as num).toInt(),
  imageUrl: json['imageUrl'] as String,
  date: DateUtils.fromJsonDateTime(json['date'] as String),
);

Map<String, dynamic> _$UserImageToJson(UserImage instance) => <String, dynamic>{
  'id': instance.id,
  'imageUrl': instance.imageUrl,
  'date': DateUtils.toJsonDateTime(instance.date),
};

UserImagesResponse _$UserImagesResponseFromJson(Map<String, dynamic> json) =>
    UserImagesResponse(
      images:
          (json['images'] as List<dynamic>)
              .map((e) => UserImage.fromJson(e as Map<String, dynamic>))
              .toList(),
      imageCount: (json['imageCount'] as num).toInt(),
    );

Map<String, dynamic> _$UserImagesResponseToJson(UserImagesResponse instance) =>
    <String, dynamic>{
      'images': instance.images,
      'imageCount': instance.imageCount,
    };
