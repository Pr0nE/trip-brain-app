import 'package:trip_brain_domain/trip_brain_domain.dart';

extension PlaceFromJson on Map<String, dynamic> {
  Place toPlace() => Place(
        title: this['title'],
        description: this['description'],
        basePlace: this['basePlace'],
        imageUrls: List<String>.from(this['imageUrls']),
      );
}

extension PlaceToJson on Place {
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'basePlace': basePlace,
      'imageUrls': imageUrls,
    };
  }
}
