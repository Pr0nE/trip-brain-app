import 'package:trip_brain_domain/trip_brain_domain.dart';

import 'package:trip_brain_data/src/api/api_client.dart';
import 'package:trip_brain_data/src/api/api_exception.dart';
import 'package:trip_brain_data/src/cache/cache_manager.dart';
import 'package:trip_brain_data/src/generated/gpt.pbgrpc.dart';

class TravelSuggestionRepository implements PlaceSuggester, PlaceImageFetcher {
  TravelSuggestionRepository({
    required this.cacheManager,
    required this.authProvider,
    required APIClient client,
  }) : client = TravelSuggestionClient(client.grpcChannel);

  final TravelSuggestionClient client;
  final AuthInfoProvider authProvider;
  final CacheManager cacheManager;

  @override
  Stream<List<Place>> suggestPlaces(PlaceSuggestionQueryModel query) {
    try {
      return client
          .suggest(
        TravelSuggestionRequest(
          accessToken: authProvider.accessToken,
          basePlace: query.basePlace,
          dislikes: query.dislikes,
          likes: query.likes,
        ),
      )
          .map<List<Place>>(
        (event) {
          return event.places
              .map((e) => Place(title: e.title, description: e.description))
              .toList();
        },
      );
    } catch (e) {
      print(e);
      // TODO
      throw APIException(status: APIExceptionStatus.unknownError);
    }
  }

  @override
  Future<List<String>> getPlaceImageUrls(Place place) async {
    if (place.imageUrls.isNotEmpty) {
      return place.imageUrls;
    }

    try {
      late PlaceImageResponse finalResponse;

      final cacheKey = getPlaceImageUrlsCacheKey(place.titleWithBase);
      final (bool isFound, Object? cacheResponse) =
          cacheManager.getCache(cacheKey);

      if (isFound && cacheResponse is PlaceImageResponse) {
        finalResponse = cacheResponse;
      } else {
        final serverResponse = await client.getPlaceImage(
          PlaceImageRequest(
            place: place.titleWithBase,
            accessToken: authProvider.accessToken,
          ),
        );

        if (serverResponse.imageUrls.isNotEmpty) {
          cacheManager.cache(cacheKey, serverResponse);
        }

        finalResponse = serverResponse;
      }

      return finalResponse.imageUrls;
    } on APIException catch (e) {
      print('Error: $e');

      rethrow;
    }
  }

  String getPlaceImageUrlsCacheKey(String place) => 'PlaceImage$place';
}
