class Place {
  final String title;
  final String description;
  final String basePlace;
  final List<String> imageUrls;

  Place({
    required this.title,
    required this.description,
    String? basePlace,
    List<String>? imageUrls,
  })  : imageUrls = imageUrls ?? [],
        basePlace = basePlace ?? '';

  String get titleWithBase => basePlace.isEmpty ? title : '$basePlace $title';

  Place copyWith({
    String? title,
    String? description,
    String? basePlace,
    List<String>? imageUrls,
    String? addImageUrl,
  }) {
    final updatedImageUrls = List<String>.from(this.imageUrls);
    if (addImageUrl != null) {
      updatedImageUrls.add(addImageUrl);
    }

    return Place(
      title: title ?? this.title,
      description: description ?? this.description,
      basePlace: basePlace ?? this.basePlace,
      imageUrls: imageUrls ?? updatedImageUrls,
    );
  }
}
