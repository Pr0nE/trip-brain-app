import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_brain_data/trip_brain_data.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/trip_brain_ui.dart';

class PlaceDetailsPage extends StatelessWidget {
  const PlaceDetailsPage({
    required this.place,
    super.key,
  });

  final Place place;

  @override
  Widget build(BuildContext context) => PlaceDetailsLayout(
        detailFetcher: context.read<PlaceDetailsRepository>(),
        place: place,
      );
}
