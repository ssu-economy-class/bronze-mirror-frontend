import 'package:firebase_analytics/firebase_analytics.dart';

final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

void logEvent({
  required String name,
  Map<String, Object>? parameters,
}) {
  analytics.logEvent(
    name: name,
    parameters: parameters,
  );
}

void logScreenView({
  required String name,
  String? screenClass,
}) {
  FirebaseAnalytics.instance.logScreenView(
    screenName: name,
    screenClass: screenClass ?? name,
  );
}