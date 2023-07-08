import 'package:trip_brain_domain/trip_brain_domain.dart';

import 'package:trip_brain_data/src/api/api_client.dart';
import 'package:trip_brain_data/src/api/api_exception.dart';
import 'package:trip_brain_data/src/cache/cache_manager.dart';
import 'package:trip_brain_data/src/generated/gpt.pbgrpc.dart';

class PlaceDetailsRepository implements PlaceDetailFetcher {
  PlaceDetailsRepository({
    required this.cacheManager,
    required this.authProvider,
    required APIClient client,
  }) : client = PlaceDetailsClient(client.grpcChannel);

  final PlaceDetailsClient client;
  final CacheManager cacheManager;
  final AuthInfoProvider authProvider;

  @override
  Stream<String> fetchDetail({
    required String place,
    required PlaceDetail detail,
  }) {
    final cacheKey = getFetchDetailCacheKey(place, detail);
    final (bool isFound, Object? cacheResponse) =
        cacheManager.getCache(cacheKey);

    if (isFound && cacheResponse is String) {
      return Stream.value(cacheResponse);
    }

    try {
      final stream = client
          .getDetail(
            GetDetailRequest(
              token: authProvider.accessToken,
              place: place,
              detail: detail.name,
            ),
          )
          .map((event) => event.content)
          .asBroadcastStream();

      String latestMessage = '';

      stream.listen(
        (message) => latestMessage = message,
        onDone: () => cacheManager.cache(cacheKey, latestMessage),
      );

      return stream;
    } catch (e) {
      print(e);
      // TODO
      throw APIException(status: APIExceptionStatus.unknownError);
    }
  }
}

String getFetchDetailCacheKey(String place, PlaceDetail detail) =>
    'GetDetail$place$detail';
