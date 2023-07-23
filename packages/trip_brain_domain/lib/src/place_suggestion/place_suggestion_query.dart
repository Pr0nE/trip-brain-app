import 'package:equatable/equatable.dart';

class PlaceSuggestionQuery extends Equatable {
  PlaceSuggestionQuery({
    required this.basePlace,
    required this.likes,
    required this.dislikes,
    required this.creationDate,
  });

  final String basePlace;
  final List<String> likes;
  final List<String> dislikes;
  final DateTime creationDate;

  factory PlaceSuggestionQuery.withBasePlace(String basePlace) =>
      PlaceSuggestionQuery(
        basePlace: basePlace,
        dislikes: [],
        likes: [],
        creationDate: DateTime.now(),
      );

  PlaceSuggestionQuery copyWith({
    String? basePlace,
    List<String>? likes,
    List<String>? dislikes,
    DateTime? suggestDate,
    String? addLike,
    String? removeLike,
    String? addDislike,
    String? removeDislike,
  }) {
    return PlaceSuggestionQuery(
      basePlace: basePlace ?? this.basePlace,
      likes: _updateList(this.likes, addLike, removeLike),
      dislikes: _updateList(this.dislikes, addDislike, removeDislike),
      creationDate: suggestDate ?? this.creationDate,
    );
  }

  List<String> _updateList(
    List<String> list,
    String? addValue,
    String? removeValue,
  ) {
    final updatedList = List<String>.from(list);

    if (addValue != null) {
      updatedList.add(addValue);
    }

    if (removeValue != null) {
      updatedList.remove(removeValue);
    }

    return updatedList;
  }

  @override
  List<Object?> get props => [basePlace, likes, dislikes];
}
