import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../api/dio_provider.dart';
import '../model/file_upload_model.dart';

part 'file_upload_repository.g.dart';

@RestApi()
abstract class FileUploadRepository {
  factory FileUploadRepository(Dio dio) = _FileUploadRepository;

  @POST('/api/file/upload')
  @MultiPart()
  Future<FileUploadResponse> uploadFile(@Part(name: "file") File file);
}

final fileUploadRepositoryProvider = Provider<FileUploadRepository>((ref) {
  final dio = ref.watch(dioAuthProvider);
  return FileUploadRepository(dio);
});
