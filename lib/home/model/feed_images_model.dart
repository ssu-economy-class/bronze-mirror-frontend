// feed_images_model.dart
import 'package:json_annotation/json_annotation.dart';

import '../../onboarding/utils/date.dart';

part 'feed_images_model.g.dart';

@JsonSerializable()
class FeedImage {
  final int id;
  final String url;
  @JsonKey(fromJson: DateUtils.fromJsonDateTime, toJson: DateUtils.toJsonDateTime)
  final DateTime date;
  final String profileImage;
  final String nickname;

  FeedImage({required this.profileImage, required this.nickname, required this.id, required this.url, required this.date});

  factory FeedImage.fromJson(Map<String, dynamic> json) => _$FeedImageFromJson(json);
  Map<String, dynamic> toJson() => _$FeedImageToJson(this);
}


@JsonSerializable()
class FeedImagesResponse {
  final List<FeedImage> content;
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;
  final bool last;

  FeedImagesResponse({
    required this.content,
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
    required this.last,
  });

  factory FeedImagesResponse.fromJson(Map<String, dynamic> json) => _$FeedImagesResponseFromJson(json['data']);
  Map<String, dynamic> toJson() => _$FeedImagesResponseToJson(this);
}
