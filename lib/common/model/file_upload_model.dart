import 'package:json_annotation/json_annotation.dart';

part 'file_upload_model.g.dart';

@JsonSerializable()
class FileUploadResponse {
  final List<String> data;

  FileUploadResponse({required this.data});

  factory FileUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$FileUploadResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FileUploadResponseToJson(this);
}
