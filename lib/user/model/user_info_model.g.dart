// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoResponse _$UserInfoResponseFromJson(Map<String, dynamic> json) =>
    UserInfoResponse(
      id: (json['id'] as num).toInt(),
      kakaoId: json['kakaoId'] as String,
      profileImage: json['profileImage'] as String,
      name: json['name'] as String,
      nickname: json['nickname'] as String,
      birthdate: json['birthdate'] as String,
      isFirst: json['isFirst'] as bool,
    );

Map<String, dynamic> _$UserInfoResponseToJson(UserInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kakaoId': instance.kakaoId,
      'profileImage': instance.profileImage,
      'name': instance.name,
      'nickname': instance.nickname,
      'birthdate': instance.birthdate,
      'isFirst': instance.isFirst,
    };
