import 'place_model.dart';
import 'place_suggestion_query_model.dart';

abstract class PlaceSuggester {
  Stream<List<Place>> suggestPlaces(PlaceSuggestionQueryModel suggestFor);
}
