import 'package:trip_brain_domain/src/place_suggestion_query_model.dart';

abstract class RecentSearchFetcher {
  Future<List<PlaceSuggestionQueryModel>> fetchRecentSearch();
}
