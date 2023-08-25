import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/core/theme_helpers.dart';

class PlaceTile extends StatefulWidget {
  const PlaceTile({
    required this.place,
    required this.imageFetcher,
    required this.onPlaceTapped,
    super.key,
  });

  final Place place;
  final PlaceImageFetcher imageFetcher;
  final void Function(Place place) onPlaceTapped;

  @override
  State<PlaceTile> createState() => _PlaceTileState();
}

class _PlaceTileState extends State<PlaceTile> {
  late Future<List<String>> imageUrls;
  late Place place;

  @override
  void initState() {
    super.initState();

    place = widget.place.copyWith();

    _getImageUrls();
  }

  @override
  void didUpdateWidget(covariant PlaceTile oldWidget) {
    place = place.copyWith(
      title: widget.place.title,
      description: widget.place.description,
    );

    super.didUpdateWidget(oldWidget);
  }

  Future<void> _getImageUrls() async {
    imageUrls = widget.imageFetcher.getPlaceImageUrls(place)
      ..then(
        (urls) => place = place.copyWith(imageUrls: urls),
      );
  }

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => widget.onPlaceTapped(place.copyWith()),
        child: Column(
          children: [
            Hero(
              tag: place.title,
              child: Text(
                place.title,
                style: context.textTheme.titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Hero(
                tag: place.description,
                child: Text(
                  place.description,
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: context.onBackground.withOpacity(0.7)),
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: FutureBuilder<List<String>>(
                future: imageUrls,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final urls = snapshot.data!;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: urls.length,
                        itemBuilder: (context, index) => Hero(
                          tag: urls[index],
                          child: CachedNetworkImage(
                            imageUrl: urls[index],
                            errorWidget: (context, url, error) =>
                                _buildShimmerPlaceHolder(),
                            placeholder: (context, url) =>
                                _buildShimmerPlaceHolder(),
                            fit: BoxFit.cover,
                            width: 300,
                            height: 300,
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 10),
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            )
          ],
        ),
      );

  Widget _buildShimmerPlaceHolder() => Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          color: context.primaryColor,
        ),
      );
}
