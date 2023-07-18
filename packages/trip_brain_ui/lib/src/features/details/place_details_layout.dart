import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/features/details/place_detail_viewer.dart';

class PlaceDetailsLayout extends StatefulWidget {
  const PlaceDetailsLayout({
    required this.place,
    required this.detailFetcher,
    required this.onError,
    super.key,
  });

  final Place place;
  final PlaceDetailFetcher detailFetcher;
  final void Function(AppException error, VoidCallback retryCallback) onError;

  @override
  State<PlaceDetailsLayout> createState() => _PlaceDetailsLayoutState();
}

class _PlaceDetailsLayoutState extends State<PlaceDetailsLayout> {
  late PlaceDetail selectedDetail;
  late List<PlaceDetail> visitedDetails;

  @override
  void initState() {
    selectedDetail = PlaceDetail.features;
    visitedDetails = [selectedDetail];

    super.initState();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: widget.place.title,
                  child: Text(
                    widget.place.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Hero(
                  tag: widget.place.description,
                  child: Text(
                    widget.place.description,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.place.imageUrls.length,
                          itemBuilder: (context, index) => Hero(
                            tag: widget.place.imageUrls[index],
                            child: CachedNetworkImage(
                              imageUrl: widget.place.imageUrls[index],
                              fit: BoxFit.cover,
                              width: 300,
                              height: 300,
                            ),
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(width: 10),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Wrap(
                              spacing: 10,
                              children: PlaceDetail.values
                                  .map(
                                    (e) => ChoiceChip(
                                      selectedColor:
                                          Theme.of(context).colorScheme.primary,
                                      onSelected: (value) => setState(() {
                                        selectedDetail = e;
                                        if (!visitedDetails
                                            .contains(selectedDetail)) {
                                          visitedDetails.add(selectedDetail);
                                        }
                                      }),
                                      label: Text(e.name),
                                      selected: selectedDetail == e,
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          Expanded(
                            child: IndexedStack(
                              index: PlaceDetail.values.indexOf(selectedDetail),
                              children: visitedDetails
                                  .map(
                                    (detail) => PlaceDetailViewer(
                                      place: widget.place.title,
                                      detail: detail,
                                      fetcher: widget.detailFetcher,
                                      onError: widget.onError,
                                    ),
                                  )
                                  .toList(),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
