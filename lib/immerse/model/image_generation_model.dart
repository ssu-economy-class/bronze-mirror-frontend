import 'package:json_annotation/json_annotation.dart';
part 'image_generation_model.g.dart';

/// 요청 모델
@JsonSerializable()
class ImageGenerationRequest {
  final String imageUrl;
  final String prompt;
  final int numInferenceSteps;

  ImageGenerationRequest({
    required this.imageUrl,
    required this.prompt,
    required this.numInferenceSteps,
  });

  Map<String, dynamic> toJson() => _$ImageGenerationRequestToJson(this);
}

/// 응답 모델
@JsonSerializable()
class ImageGenerationResponse {
  final String savedImageUrl;
  final String generatedImageUrl;

  ImageGenerationResponse({
    required this.savedImageUrl,
    required this.generatedImageUrl,
  });

  factory ImageGenerationResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageGenerationResponseFromJson(json);
}