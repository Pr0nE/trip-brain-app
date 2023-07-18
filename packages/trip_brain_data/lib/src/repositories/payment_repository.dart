import 'dart:async';

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grpc/grpc.dart';
import 'package:trip_brain_data/src/api/api_client.dart';
import 'package:trip_brain_data/src/generated/gpt.pbgrpc.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

class PaymentRepository implements PaymentManager {
  PaymentRepository({
    required APIClient client,
    required this.authProvider,
    required this.appModeProvider,
  }) : client = PaymentClient(client.grpcChannel) {
    Stripe.publishableKey =
        "pk_test_51NPmXZKTTuS399b7KRgomoxGmopcwI7bFgJTZAXKwru3wYSERZeF0wOtFJoRXVaUHvb8hm3ZkYnXx0yX1BpWNgOM007czCNlKC";
  }
  final AuthInfoProvider authProvider;
  final AppModeProvider appModeProvider;
  final PaymentClient client;

  @override
  Future<bool> buyBalance(int amount) async {
    if (appModeProvider.isAppOffline) {
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
      if (error is GrpcError) {
        switch (error.code) {
          case StatusCode.unavailable:
            throw AppException(AppErrorType.network);
          case StatusCode.unauthenticated:
            throw AppException(AppErrorType.expiredToken);

          default:
            throw AppException(AppErrorType.unknown, message: error.message);
        }
      }
      if (error is StripeException) {
        throw AppException(
          AppErrorType.unknown,
          message: error.error.localizedMessage,
        );
      }

      throw AppException(AppErrorType.unknown, message: error.toString());
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
      if (error is GrpcError) {
        switch (error.code) {
          case StatusCode.unavailable:
            throw AppException(AppErrorType.network);
          case StatusCode.unauthenticated:
            throw AppException(AppErrorType.expiredToken);

          default:
            throw AppException(AppErrorType.unknown, message: error.message);
        }
      }
      throw AppException(AppErrorType.unknown, message: error.toString());
    }
  }
}
