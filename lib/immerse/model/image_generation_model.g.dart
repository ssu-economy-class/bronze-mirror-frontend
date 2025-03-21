// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_generation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageGenerationRequest _$ImageGenerationRequestFromJson(
  Map<String, dynamic> json,
) => ImageGenerationRequest(
  imageUrl: json['imageUrl'] as String,
  prompt: json['prompt'] as String,
  numInferenceSteps: (json['numInferenceSteps'] as num).toInt(),
);

Map<String, dynamic> _$ImageGenerationRequestToJson(
  ImageGenerationRequest instance,
) => <String, dynamic>{
  'imageUrl': instance.imageUrl,
  'prompt': instance.prompt,
  'numInferenceSteps': instance.numInferenceSteps,
};

ImageGenerationResponse _$ImageGenerationResponseFromJson(
  Map<String, dynamic> json,
) => ImageGenerationResponse(
  savedImageUrl: json['savedImageUrl'] as String,
  generatedImageUrl: json['generatedImageUrl'] as String,
);

Map<String, dynamic> _$ImageGenerationResponseToJson(
  ImageGenerationResponse instance,
) => <String, dynamic>{
  'savedImageUrl': instance.savedImageUrl,
  'generatedImageUrl': instance.generatedImageUrl,
};
