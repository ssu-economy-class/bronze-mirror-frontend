import 'package:json_annotation/json_annotation.dart';

part 'kakao_register_model.g.dart';

/// 요청 모델
@JsonSerializable()
class KakaoRegisterRequest {
  final String kakaoId;
  final String profileImage;
  final String name;
  final String nickname;
  final String birthdate;

  KakaoRegisterRequest({
    required this.kakaoId,
    required this.profileImage,
    required this.name,
    required this.nickname,
    required this.birthdate,
  });

  Map<String, dynamic> toJson() => _$KakaoRegisterRequestToJson(this);
}

/// 응답 모델
@JsonSerializable()
class KakaoRegisterResponse {
  final String message;
  final bool isSuccess;
  final KakaoRegisterResponseData data;
  final String code;

  KakaoRegisterResponse({
    required this.message,
    required this.isSuccess,
    required this.data,
    required this.code,
  });

  factory KakaoRegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$KakaoRegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KakaoRegisterResponseToJson(this);
}

/// 응답 내부 데이터 모델
@JsonSerializable()
class KakaoRegisterResponseData {
  final bool isFirst;
  final String name;
  final int id;
  final String profileImage;
  final String accessToken;

  KakaoRegisterResponseData({
    required this.isFirst,
    required this.name,
    required this.id,
    required this.profileImage,
    required this.accessToken,
  });

  factory KakaoRegisterResponseData.fromJson(Map<String, dynamic> json) =>
      _$KakaoRegisterResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$KakaoRegisterResponseDataToJson(this);
}