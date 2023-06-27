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
              .map((e) => Place(e.title, e.description))
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
  Future<List<String>> getPlaceImageUrls(String place) async {
    try {
      late PlaceImageResponse finalResponse;

      // Check cache
      final (bool isFound, Object? cacheResponse) =
          cacheManager.getCache(place);

      if (isFound && cacheResponse is PlaceImageResponse) {
        finalResponse = cacheResponse;
      } else {
        // final apiResult = await apiClient.request(
        //   Uri(
        //     scheme: 'https',
        //     host: 'api.unsplash.com',
        //     path: '/search/photos',
        //     queryParameters: {'query': place, 'page': '1'},
        //   ),
        //   extraHeaders: {
        //     'Authorization':
        //         'Client-ID 6pGGqKwnsKu4sG9rjGTQQjmUmxtjtkfJP_jD383A_oo'
        //   },
        // );

        final serverResponse = await client.getPlaceImage(
          PlaceImageRequest(
            place: place,
            accessToken: authProvider.accessToken,
          ),
        );

        finalResponse = serverResponse;
        cacheManager.cache(place, finalResponse);
      }

      return finalResponse.imageUrls;
    } on APIException catch (e) {
      print('Error: $e');

      rethrow;
    }
  }
}


// class ImageRepository {
//   ImageRepository(this.client);

//   final APIClient client;

//   Future<String> getImage(String query) async {
//     try {
//       final response = await client.request(
//           Uri(
//             scheme: 'https',
//             host: 'api.unsplash.com',
//             path: '/search/photos',
//             queryParameters: {'query': query, 'page': '1'},
//           ),
//           extraHeaders: {
//             'Authorization':
//                 'Client-ID 6pGGqKwnsKu4sG9rjGTQQjmUmxtjtkfJP_jD383A_oo'
//           });

//       final result = ImageResponse.fromJson(response);

//       return result.results
//               ?.map((e) => e.urls?.regular)
//               .toList()
//               .whereNotNull()
//               .toList()
//               .first ??
//           '';
//     } on APIException catch (e) {
//       print('Error: $e');

//       return '';
//     }
//   }
// }
