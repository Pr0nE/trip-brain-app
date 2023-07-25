import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

import 'place_detail_viewer_cubit.dart';

class PlaceDetailViewer extends StatefulWidget {
  const PlaceDetailViewer({
    required this.place,
    required this.detail,
    required this.fetcher,
    required this.onError,
    super.key,
  });

  final String place;
  final PlaceDetail detail;
  final PlaceDetailFetcher fetcher;
  final void Function(AppException error, VoidCallback retryCallback) onError;

  @override
  State<PlaceDetailViewer> createState() => _PlaceDetailViewerState();
}

class _PlaceDetailViewerState extends State<PlaceDetailViewer> {
  late final PlaceDetailViewerCubit cubit;

  @override
  void initState() {
    cubit = PlaceDetailViewerCubit(fetcher: widget.fetcher)
      ..fetchDetails(widget.place, widget.detail);

    super.initState();
  }

  @override
  Widget build(BuildContext context) =>
      BlocConsumer<PlaceDetailViewerCubit, PlaceDetailViewerState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is PlaceDetailViewerErrorState) {
            widget.onError(state.error, state.retryCallback);
          }
        },
        builder: (context, state) => state is PlaceDetailViewerLoadingState
            ? const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Markdown(data: state.loaded?.content ?? ''),
      );
}
