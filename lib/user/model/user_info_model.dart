import 'package:json_annotation/json_annotation.dart';
part 'user_info_model.g.dart';


/// 응답 모델
@JsonSerializable()
class UserInfoResponse {
  final int id;
  final String kakaoId;
  final String profileImage;
  final String name;
  final String nickname;
  final String birthdate;
  final bool isFirst;

  UserInfoResponse({
    required this.id,
    required this.kakaoId,
    required this.profileImage,
    required this.name,
    required this.nickname,
    required this.birthdate,
    required this.isFirst,
  });

  factory UserInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$UserInfoResponseFromJson(json['data']);

  Map<String, dynamic> toJson() => _$UserInfoResponseToJson(this);
}