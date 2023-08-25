import 'package:trip_brain_domain/src/place_suggestion/place.dart';

abstract class PlaceImageFetcher {
  Future<List<String>> getPlaceImageUrls(Place place);
}
