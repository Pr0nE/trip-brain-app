import 'package:trip_brain_domain/trip_brain_domain.dart';

extension SuggestionQueryFromJson on Map<String, dynamic> {
  PlaceSuggestionQuery toSuggestionQuery() => PlaceSuggestionQuery(
        basePlace: this['basePlace'],
        likes: List<String>.from(this['likes']),
        dislikes: List<String>.from(this['dislikes']),
      );
}

extension SuggestionQueryToJson on PlaceSuggestionQuery {
  Map<String, dynamic> toJson() => {
        'basePlace': basePlace,
        'likes': likes,
        'dislikes': dislikes,
      };
}
