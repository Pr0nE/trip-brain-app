import 'place.dart';
import 'place_suggestion_query.dart';

abstract class PlaceSuggester {
  Stream<List<Place>> suggestPlaces(PlaceSuggestionQuery suggestFor);
}
