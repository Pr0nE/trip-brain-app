import 'package:trip_brain_domain/src/place_suggestion/place_suggestion_query.dart';

abstract class RecentSuggestionsFetcher {
  Future<List<PlaceSuggestionQuery>> fetchRecentSuggestions();
}
