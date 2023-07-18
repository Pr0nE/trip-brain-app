import 'dart:async';
import 'dart:convert';

import 'package:grpc/grpc.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

import 'package:trip_brain_data/src/api/api_client.dart';
import 'package:trip_brain_data/src/cache/cache_manager.dart';
import 'package:trip_brain_data/src/generated/gpt.pbgrpc.dart';

class TravelSuggestionRepository
    implements PlaceSuggester, PlaceImageFetcher, RecentSearchFetcher {
  TravelSuggestionRepository({
    required this.cacheManager,
    required this.authProvider,
    required this.appModeProvider,
    required APIClient client,
  }) : client = TravelSuggestionClient(client.grpcChannel);

  static const _suggestionSearchesTableKey = 'suggestionSearchesTableKey';
  final TravelSuggestionClient client;
  final AuthInfoProvider authProvider;
  final AppModeProvider appModeProvider;
  final CacheManager cacheManager;

  @override
  Stream<List<Place>> suggestPlaces(PlaceSuggestionQueryModel query) {
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
              .map((data) => Place.fromJson(data as Map<String, dynamic>))
              .toList();

          controller.add(cachedPlaces);
          controller.close();
        } else {
          if (appModeProvider.isAppOffline) {
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

  @override
  Future<List<PlaceSuggestionQueryModel>> fetchRecentSearch() async {
    final Map<String, String> entries =
        await cacheManager.getTableEntries(_suggestionSearchesTableKey);

    return entries.keys
        .map((json) => PlaceSuggestionQueryModel.fromJson(jsonDecode(json)))
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
      final List decoded = jsonDecode(cachedData);
      return decoded.map((e) => e.toString()).toList();
    }

    if (appModeProvider.isAppOffline) {
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
