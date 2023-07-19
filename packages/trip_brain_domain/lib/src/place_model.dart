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
  }) =>
      Place(
        title: title ?? this.title,
        description: description ?? this.description,
        basePlace: basePlace ?? this.basePlace,
        imageUrls: imageUrls ?? this.imageUrls,
      );

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'basePlace': basePlace,
      'imageUrls': imageUrls,
    };
  }

  // TODO: Move mapper to data
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      title: json['title'],
      description: json['description'],
      basePlace: json['basePlace'],
      imageUrls: List<String>.from(json['imageUrls']),
    );
  }
}
