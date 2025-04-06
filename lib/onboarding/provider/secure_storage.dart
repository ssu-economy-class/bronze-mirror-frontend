import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// accessToken 등과 같은 민감한 정보를 로컬에 저장하기 위한 FlutterSecureStorage의 Provider
final secureStorageProvider = Provider<FlutterSecureStorage>((ref)=> FlutterSecureStorage());