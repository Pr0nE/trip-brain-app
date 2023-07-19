import 'package:equatable/equatable.dart';

class PlaceSuggestionQueryModel extends Equatable {
  PlaceSuggestionQueryModel({
    required this.basePlace,
    required this.likes,
    required this.dislikes,
  });

  final String basePlace;
  final List<String> likes;
  final List<String> dislikes;

  factory PlaceSuggestionQueryModel.withBasePlace(String basePlace) =>
      PlaceSuggestionQueryModel(
        basePlace: basePlace,
        dislikes: [],
        likes: [],
      );

  PlaceSuggestionQueryModel copyWith({
    String? basePlace,
    List<String>? likes,
    List<String>? dislikes,
    String? addLike,
    String? removeLike,
    String? addDislike,
    String? removeDislike,
  }) {
    return PlaceSuggestionQueryModel(
      basePlace: basePlace ?? this.basePlace,
      likes: _updateList(this.likes, addLike, removeLike),
      dislikes: _updateList(this.dislikes, addDislike, removeDislike),
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

  Map<String, dynamic> toJson() {
    return {
      'basePlace': basePlace,
      'likes': likes,
      'dislikes': dislikes,
    };
  }

  // TODO: Move mapper to data
  factory PlaceSuggestionQueryModel.fromJson(Map<String, dynamic> json) {
    return PlaceSuggestionQueryModel(
      basePlace: json['basePlace'],
      likes: List<String>.from(json['likes']),
      dislikes: List<String>.from(json['dislikes']),
    );
  }

  @override
  List<Object?> get props => [basePlace, likes, dislikes];
}
