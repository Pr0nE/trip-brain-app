import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:grpc/grpc.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

extension ExceptionMapper on Object {
  AppException toAppException() {
    final error = this;
    if (error is AppException) {
      return error;
    }

    if (error is GrpcError) {
      switch (error.code) {
        case StatusCode.resourceExhausted:
          return AppException(AppErrorType.insufficientBalance);
        case StatusCode.unavailable ||
              StatusCode.unknown ||
              StatusCode.deadlineExceeded:
          return AppException(AppErrorType.network);
        case StatusCode.unauthenticated:
          return AppException(AppErrorType.needAuth);

        default:
          return AppException(AppErrorType.unknown, message: error.message);
      }
    }

    if (error is StripeException) {
      return AppException(
        AppErrorType.payment,
        message: error.error.localizedMessage,
      );
    }

    return AppException(AppErrorType.unknown, message: error.toString());
  }
}
