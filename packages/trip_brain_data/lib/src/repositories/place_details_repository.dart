import 'dart:async';

import 'package:grpc/grpc.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

import 'package:trip_brain_data/src/api/api_client.dart';
import 'package:trip_brain_data/src/cache/cache_manager.dart';
import 'package:trip_brain_data/src/generated/gpt.pbgrpc.dart';

class PlaceDetailsRepository implements PlaceDetailFetcher {
  PlaceDetailsRepository({
    required this.cacheManager,
    required this.authProvider,
    required this.appModeProvider,
    required APIClient client,
  }) : client = PlaceDetailsClient(client.grpcChannel);

  static const _placeDetailsTableKey = 'placeDetailsTableKey';
  final PlaceDetailsClient client;
  final CacheManager cacheManager;
  final AuthInfoProvider authProvider;
  final AppModeProvider appModeProvider;

  @override
  Stream<String> fetchDetail({
    required String place,
    required PlaceDetail detail,
  }) {
    try {
      final StreamController<String> controller = StreamController.broadcast();

      final cacheKey = getFetchDetailCacheKey(place, detail);

      cacheManager
          .getJsonData(cacheKey, table: _placeDetailsTableKey)
          .then((cacheResponse) {
        if (cacheResponse != null) {
          controller.add(cacheResponse);
          controller.close();
        } else {
          if (appModeProvider.isAppOffline) {
            controller.addError(AppException(AppErrorType.needNetwork));
            controller.close();
            return;
          }

          String latestMessage = '';

          client
              .getDetail(
                GetDetailRequest(
                  token: authProvider.accessToken,
                  place: place,
                  detail: detail.name,
                ),
              )
              .map((event) => event.content)
              .listen(
            (message) {
              latestMessage = message;
              controller.add(message);
            },
            onDone: () {
              if (latestMessage.isNotEmpty) {
                cacheManager.saveJsonData(
                  cacheKey,
                  latestMessage,
                  table: _placeDetailsTableKey,
                );
              }
              controller.close();
            },
          );
        }
      });

      return controller.stream;
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

String getFetchDetailCacheKey(String place, PlaceDetail detail) =>
    'GetDetail$place$detail';
