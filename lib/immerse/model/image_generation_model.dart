import 'package:json_annotation/json_annotation.dart';
part 'image_generation_model.g.dart';

/// 요청 모델
@JsonSerializable()
class ImageGenerationRequest {
  final String userId;
  final String imageUrl;
  final String prompt;

  ImageGenerationRequest({
    required this.userId,
    required this.imageUrl,
    required this.prompt,
  });

  Map<String, dynamic> toJson() => _$ImageGenerationRequestToJson(this);
}

/// 응답 모델
@JsonSerializable()
class ImageGenerationResponse {
  final String savedImageUrl;

  ImageGenerationResponse({
    required this.savedImageUrl,
  });

  factory ImageGenerationResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageGenerationResponseFromJson(json);
}