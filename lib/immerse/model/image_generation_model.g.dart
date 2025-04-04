// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_generation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageGenerationRequest _$ImageGenerationRequestFromJson(
  Map<String, dynamic> json,
) => ImageGenerationRequest(
  userId: json['userId'] as String,
  imageUrl: json['imageUrl'] as String,
  prompt: json['prompt'] as String,
);

Map<String, dynamic> _$ImageGenerationRequestToJson(
  ImageGenerationRequest instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'imageUrl': instance.imageUrl,
  'prompt': instance.prompt,
};

ImageGenerationResponse _$ImageGenerationResponseFromJson(
  Map<String, dynamic> json,
) => ImageGenerationResponse(savedImageUrl: json['savedImageUrl'] as String);

Map<String, dynamic> _$ImageGenerationResponseToJson(
  ImageGenerationResponse instance,
) => <String, dynamic>{'savedImageUrl': instance.savedImageUrl};
