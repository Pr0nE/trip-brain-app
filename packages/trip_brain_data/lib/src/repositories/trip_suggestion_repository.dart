import 'dart:async';
import 'dart:convert';

import 'package:trip_brain_data/src/exceptions/exception_mappers.dart';
import 'package:trip_brain_data/src/mappers/place_dto_mappers.dart';
import 'package:trip_brain_data/src/mappers/place_suggestion_query_dto_mappers.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

import 'package:trip_brain_data/src/api/api_client.dart';
import 'package:trip_brain_domain/src/core/cache_manager.dart';
import 'package:trip_brain_data/src/generated/gpt.pbgrpc.dart';

class TravelSuggestionRepository
    implements PlaceSuggester, PlaceImageFetcher, RecentSuggestionsFetcher {
  TravelSuggestionRepository({
    required this.cacheManager,
    required this.authProvider,
    required this.appSettingsProvider,
    required APIClient client,
  }) : client = TravelSuggestionClient(client.grpcChannel);

  static const _suggestionSearchesTableKey = 'suggestionSearchesTableKey';

  final TravelSuggestionClient client;
  final AuthInfoProvider authProvider;
  final CacheManager cacheManager;
  final AppSettingsProvider appSettingsProvider;

  @override
  Stream<List<Place>> suggestPlaces(PlaceSuggestionQuery query) {
    try {
      final StreamController<List<Place>> controller =
          StreamController.broadcast();

      final queryKey = jsonEncode(query.toJson());

      cacheManager
          .getJsonData(
        queryKey,
        table: _suggestionSearchesTableKey,
      )
          .then((cacheResponse) {
        if (cacheResponse != null) {
          final List<dynamic> jsonData = jsonDecode(cacheResponse);
          final List<Place> cachedPlaces = jsonData
              .map((data) => (data as Map<String, dynamic>).toPlace())
              .toList();

          controller.add(cachedPlaces);
          controller.close();
        } else {
          if (appSettingsProvider.isAppOffline) {
            controller.addError(AppException(AppErrorType.needNetwork));
            controller.close();
            return;
          }

          List<Place>? remoteResponse;

          client
              .suggest(
                TravelSuggestionRequest(
                  accessToken: authProvider.accessToken,
                  basePlace: query.basePlace,
                  dislikes: query.dislikes,
                  likes: query.likes,
                  language: appSettingsProvider.appLanguage,
                ),
              )
              .map<List<Place>>(
                (event) => event.places
                    .map(
                      (e) => Place(
                        title: e.title,
                        description: e.description,
                      ),
                    )
                    .toList(),
              )
              .listen(
            (event) {
              remoteResponse = event;
              controller.add(event);
            },
            onDone: () {
              if (remoteResponse != null) {
                cacheManager.saveJsonData(
                  jsonEncode(query.toJson()),
                  jsonEncode(remoteResponse?.map((e) => e.toJson()).toList()),
                  table: _suggestionSearchesTableKey,
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

  @override
  Future<List<PlaceSuggestionQuery>> fetchRecentSuggestions() async {
    final Map<String, String> entries =
        await cacheManager.getTableEntries(_suggestionSearchesTableKey);

    return entries.keys
        .map((json) {
          final jsonMap = jsonDecode(json) as Map<String, dynamic>;
          return jsonMap.toSuggestionQuery();
        })
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<List<String>> getPlaceImageUrls(Place place) async {
    if (place.imageUrls.isNotEmpty) {
      return place.imageUrls;
    }
    final queryKey = getPlaceImageUrlsCacheKey(place.titleWithBase);

    final cachedData = await cacheManager.getJsonData(queryKey);

    if (cachedData != null) {
      final List<dynamic> decoded = jsonDecode(cachedData);
      return decoded.map((e) => e.toString()).toList();
    }

    if (appSettingsProvider.isAppOffline) {
      return [];
    }

    final response = await client.getPlaceImage(
      PlaceImageRequest(
        place: place.titleWithBase,
        accessToken: authProvider.accessToken,
      ),
    );

    cacheManager.saveJsonData(getPlaceImageUrlsCacheKey(place.titleWithBase),
        jsonEncode(response.imageUrls));

    return response.imageUrls;
  }

  String getPlaceImageUrlsCacheKey(String place) => 'PlaceImage$place';
}
