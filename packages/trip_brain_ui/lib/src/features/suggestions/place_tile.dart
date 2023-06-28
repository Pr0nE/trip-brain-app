import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

class PlaceTile extends StatefulWidget {
  const PlaceTile({
    required this.title,
    required this.description,
    required this.imageFetcher,
    this.basePlace,
    super.key,
  });

  final String title;
  final String description;
  final String? basePlace;
  final PlaceImageFetcher imageFetcher;

  @override
  State<PlaceTile> createState() => _PlaceTileState();
}

class _PlaceTileState extends State<PlaceTile> {
  @override
  void initState() {
    super.initState();

    final place = '${widget.basePlace ?? ''} ${widget.title}';
    imageUrls = widget.imageFetcher.getPlaceImageUrls(place);
  }

  late Future<List<String>> imageUrls;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(
            widget.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.description,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          SizedBox(
            height: 200,
            child: FutureBuilder<List<String>>(
              future: imageUrls,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                if (snapshot.hasData) {
                  final urls = snapshot.data!;

                  return ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: urls.length,
                    itemBuilder: (context, index) => CachedNetworkImage(
                      imageUrl: urls[index],
                      fit: BoxFit.cover,
                      width: 300,
                      height: 300,
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                  );
                }

                return const SizedBox();
              },
            ),
          )
        ],
      );
}
