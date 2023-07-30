import 'dart:async';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:trip_brain_data/src/api/api_client.dart';
import 'package:trip_brain_data/src/exceptions/exception_mappers.dart';
import 'package:trip_brain_data/src/generated/gpt.pbgrpc.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

class PaymentRepository implements PaymentManager {
  PaymentRepository({
    required APIClient client,
    required this.authProvider,
    required this.appSettingsProvider,
  }) : client = client.paymentClient {
    Stripe.publishableKey =
        "pk_test_51NPmXZKTTuS399b7KRgomoxGmopcwI7bFgJTZAXKwru3wYSERZeF0wOtFJoRXVaUHvb8hm3ZkYnXx0yX1BpWNgOM007czCNlKC";
  }
  final AuthInfoProvider authProvider;
  final AppSettingsProvider appSettingsProvider;
  final PaymentClient client;

  @override
  Future<bool> buyBalance(int amount) async {
    if (appSettingsProvider.isAppOffline) {
      throw AppException(AppErrorType.needNetwork);
    }
    try {
      final buyResponse = await _buyCredit(amount);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: buyResponse.clientSecret,
          merchantDisplayName: 'Trip Brain',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      return true;
    } catch (error) {
      throw error.toAppException();
    }
  }

  Future<BuyCreditResponse> _buyCredit(int amount) {
    try {
      return client.buyCredit(
        BuyCreditRequest(
          token: authProvider.accessToken,
          amount: amount,
        ),
      );
    } catch (error) {
      throw error.toAppException();
    }
  }
}
