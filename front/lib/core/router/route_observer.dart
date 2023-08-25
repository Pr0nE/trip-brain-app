import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class AnalyticRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      FirebaseAnalytics.instance.logEvent(
          name: 'pushPage', parameters: {'pageName': route.settings.name});

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) =>
      FirebaseAnalytics.instance.logEvent(
          name: 'popPage', parameters: {'pageName': route.settings.name});
}
