import 'package:json_annotation/json_annotation.dart';

import '../../onboarding/utils/date.dart';

part 'user_images_model.g.dart';

@JsonSerializable()
class UserImage {
  final int id;
  final String imageUrl;
  @JsonKey(fromJson: DateUtils.fromJsonDateTime, toJson: DateUtils.toJsonDateTime)
  final DateTime date;

  UserImage({required this.id, required this.imageUrl, required this.date});

  factory UserImage.fromJson(Map<String, dynamic> json) => _$UserImageFromJson(json);
  Map<String, dynamic> toJson() => _$UserImageToJson(this);
}

@JsonSerializable()
class UserImagesResponse {
  final List<UserImage> images;
  final int imageCount;

  UserImagesResponse({required this.images, required this.imageCount});

  factory UserImagesResponse.fromJson(Map<String, dynamic> json) =>
      _$UserImagesResponseFromJson(json['data']);
}