import 'package:trip_brain_domain/src/place_details/place_detail.dart';

abstract class PlaceDetailFetcher {
  Stream<String> fetchDetail({
    required String place,
    required PlaceDetail detail,
  });
}
