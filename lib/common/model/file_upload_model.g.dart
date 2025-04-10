// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_upload_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileUploadResponse _$FileUploadResponseFromJson(Map<String, dynamic> json) =>
    FileUploadResponse(
      data: (json['data'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$FileUploadResponseToJson(FileUploadResponse instance) =>
    <String, dynamic>{'data': instance.data};
