import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

void onGuestLoginTappedEvent() =>
    FirebaseAnalytics.instance.logEvent(name: 'GuestLoginTap');

void onSocialLoginTappedEvent() =>
    FirebaseAnalytics.instance.logEvent(name: 'SocialLoginTap');

void onBuyBalanceEvent(int amount) => FirebaseAnalytics.instance
    .logEvent(name: 'BuyBalance', parameters: {'amount': amount});

void onDetailTappedEvent(PlaceDetail detail) => FirebaseAnalytics.instance
    .logEvent(name: 'DetailTapped', parameters: {'detail': detail.name});

void onAppExceptionEvent(AppException error) =>
    FirebaseAnalytics.instance.logEvent(
      name: 'AppException',
      parameters: {'type': error.type.name, 'message': error.toString()},
    );
