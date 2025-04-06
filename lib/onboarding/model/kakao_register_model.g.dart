// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kakao_register_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KakaoRegisterRequest _$KakaoRegisterRequestFromJson(
  Map<String, dynamic> json,
) => KakaoRegisterRequest(
  kakaoId: json['kakaoId'] as String,
  profileImage: json['profileImage'] as String,
  name: json['name'] as String,
  nickname: json['nickname'] as String,
  birthdate: json['birthdate'] as String,
);

Map<String, dynamic> _$KakaoRegisterRequestToJson(
  KakaoRegisterRequest instance,
) => <String, dynamic>{
  'kakaoId': instance.kakaoId,
  'profileImage': instance.profileImage,
  'name': instance.name,
  'nickname': instance.nickname,
  'birthdate': instance.birthdate,
};

KakaoRegisterResponse _$KakaoRegisterResponseFromJson(
  Map<String, dynamic> json,
) => KakaoRegisterResponse(
  message: json['message'] as String,
  isSuccess: json['isSuccess'] as bool,
  data: KakaoRegisterResponseData.fromJson(
    json['data'] as Map<String, dynamic>,
  ),
  code: json['code'] as String,
);

Map<String, dynamic> _$KakaoRegisterResponseToJson(
  KakaoRegisterResponse instance,
) => <String, dynamic>{
  'message': instance.message,
  'isSuccess': instance.isSuccess,
  'data': instance.data,
  'code': instance.code,
};

KakaoRegisterResponseData _$KakaoRegisterResponseDataFromJson(
  Map<String, dynamic> json,
) => KakaoRegisterResponseData(
  isFirst: json['isFirst'] as bool,
  name: json['name'] as String,
  id: (json['id'] as num).toInt(),
  profileImage: json['profileImage'] as String,
  accessToken: json['accessToken'] as String,
);

Map<String, dynamic> _$KakaoRegisterResponseDataToJson(
  KakaoRegisterResponseData instance,
) => <String, dynamic>{
  'isFirst': instance.isFirst,
  'name': instance.name,
  'id': instance.id,
  'profileImage': instance.profileImage,
  'accessToken': instance.accessToken,
};
