import 'dart:async';

import 'package:trip_brain_data/src/exceptions/exception_mappers.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

import 'package:trip_brain_data/src/api/api_client.dart';
import 'package:trip_brain_data/src/cache/cache_manager.dart';
import 'package:trip_brain_data/src/generated/gpt.pbgrpc.dart';

class PlaceDetailsRepository implements PlaceDetailFetcher {
  PlaceDetailsRepository({
    required this.cacheManager,
    required this.authProvider,
    required this.appSettingsProvider,
    required APIClient client,
  }) : client = PlaceDetailsClient(client.grpcChannel);

  static const _placeDetailsTableKey = 'placeDetailsTableKey';
  final PlaceDetailsClient client;
  final CacheManager cacheManager;
  final AuthInfoProvider authProvider;
  final AppSettingsProvider appSettingsProvider;

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
          if (appSettingsProvider.isAppOffline) {
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
                  language: appSettingsProvider.appLanguage,
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
            onError: (Object error) {
              controller.addError(error.toAppException());
              controller.close();
              return;
            },
          );
        }
      });

      return controller.stream;
    } catch (error) {
      throw error.toAppException();
    }
  }
}

String getFetchDetailCacheKey(String place, PlaceDetail detail) =>
    'GetDetail$place$detail';
