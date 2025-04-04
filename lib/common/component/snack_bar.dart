import 'package:flutter/material.dart';

// 알림바를 띄우는 함수입니다. 이건 함수로 쳐야하나 컴포로 쳐야하나...
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}