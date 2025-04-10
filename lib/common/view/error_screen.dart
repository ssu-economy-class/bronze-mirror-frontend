import 'package:bronze_mirror/common/style/design_system.dart';
import 'package:flutter/material.dart';

import '../api/firebase_analytics.dart';

class ErrorScreen extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;

  const ErrorScreen({super.key, required this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    logScreenView(name: 'FeedScreen');
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: BACKGROUND),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              message,
              style: SUB_TITLE_19.copyWith(color: WHITE),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed:
                  onRetry ??
                  () {
                    Navigator.of(context).pop();
                    logEvent(
                      name: '새로고침',
                      parameters: {
                        'screen': 'error',
                        'button': 'refresh',
                      },
                    );
                  },
              child: const Text(
                '새로고침',
                style: TextStyle(color: Color(0XFFCCCCCC)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
