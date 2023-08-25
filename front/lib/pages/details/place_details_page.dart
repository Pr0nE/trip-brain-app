import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trip_brain_app/core/helpers/app_helper.dart';
import 'package:trip_brain_app/core/dialog/dialog_manager.dart';
import 'package:trip_brain_app/core/helpers/event_helper.dart';
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
  Widget build(BuildContext context) => Provider(
        create: (context) => DialogManager(context),
        child: Builder(
          builder: (context) => PlaceDetailsLayout(
            detailFetcher: context.read<PlaceDetailsRepository>(),
            onDetailTapped: onDetailTappedEvent,
            place: place,
            onError: (error, retryCallback) => checkAppError(
              context: context,
              error: error,
              onRetry: retryCallback,
            ),
          ),
        ),
      );
}
