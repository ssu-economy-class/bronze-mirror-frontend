import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saver_gallery/saver_gallery.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

Future<void> downloadAndSaveImage(BuildContext context, String url) async {
  // 권한 요청
  bool hasPermission = await checkAndRequestPermissions(skipIfExists: false);
  if (!hasPermission) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('갤러리 접근 권한이 필요합니다.')),
    );
    return;
  }

  try {
    // 이미지 다운로드
    var response = await Dio().get(
      url,
      options: Options(responseType: ResponseType.bytes),
    );

    // URL에서 파일명 추출
    String fileName = url.split('/').last;

    // 갤러리에 이미지 저장
    final result = await SaverGallery.saveImage(
      Uint8List.fromList(response.data),
      fileName: fileName,
      androidRelativePath: "Pictures/YourAppName",
      skipIfExists: false,
    );

    if (result.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이미지가 갤러리에 저장되었습니다.')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('이미지 저장에 실패했습니다.')),
      );
    }
  } catch (e) {
    print("다운로드 실패: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('이미지 다운로드에 실패했습니다.')),
    );
  }
}

void shareImage(String url) {
  Share.share(url);
}

Future<bool> checkAndRequestPermissions({required bool skipIfExists}) async {
  if (!Platform.isAndroid && !Platform.isIOS) {
    return false;
  }

  if (Platform.isAndroid) {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    final sdkInt = deviceInfo.version.sdkInt;

    if (skipIfExists) {
      return sdkInt >= 33
          ? await Permission.photos.request().isGranted
          : await Permission.storage.request().isGranted;
    } else {
      return sdkInt >= 29 ? true : await Permission.storage.request().isGranted;
    }
  } else if (Platform.isIOS) {
    return skipIfExists
        ? await Permission.photos.request().isGranted
        : await Permission.photosAddOnly.request().isGranted;
  }

  return false;
}