import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../repository/file_upload_repository.dart';

final fileUploadProvider = Provider<FileUploadService>((ref) {
  final repo = ref.watch(fileUploadRepositoryProvider);
  return FileUploadService(repository: repo);
});

class FileUploadService {
  final FileUploadRepository repository;

  FileUploadService({required this.repository});

  Future<String> upload(File file) async {
    final response = await repository.uploadFile(file);
    return response.data.first;
  }
}
