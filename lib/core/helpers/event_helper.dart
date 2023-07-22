import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:flutter/foundation.dart' as foundation;

void onGuestLoginTappedEvent() {
  if (foundation.kReleaseMode) {
    FirebaseAnalytics.instance.logEvent(name: 'GuestLoginTap');
  }
}

void onSocialLoginTappedEvent() {
  if (foundation.kReleaseMode) {
    FirebaseAnalytics.instance.logEvent(name: 'SocialLoginTap');
  }
}

void onBuyBalanceEvent(int amount) {
  if (foundation.kReleaseMode) {
    FirebaseAnalytics.instance
        .logEvent(name: 'BuyBalance', parameters: {'amount': amount});
  }
}

void onDetailTappedEvent(PlaceDetail detail) {
  if (foundation.kReleaseMode) {
    FirebaseAnalytics.instance
        .logEvent(name: 'DetailTapped', parameters: {'detail': detail.name});
  }
}

void onAppExceptionEvent(AppException error) {
  if (foundation.kReleaseMode) {
    FirebaseAnalytics.instance.logEvent(
      name: 'AppException',
      parameters: {'type': error.type.name, 'message': error.toString()},
    );
  }
}
