import 'package:trip_brain_domain/src/place_model.dart';

abstract class PlaceImageFetcher {
  Future<List<String>> getPlaceImageUrls(Place place);
}
