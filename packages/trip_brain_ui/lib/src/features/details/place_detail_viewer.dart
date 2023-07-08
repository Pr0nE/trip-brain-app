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
    super.key,
  });

  final String place;
  final PlaceDetail detail;
  final PlaceDetailFetcher fetcher;

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
      BlocBuilder<PlaceDetailViewerCubit, PlaceDetailViewerState>(
        bloc: cubit,
        builder: (context, state) =>
            Markdown(data: state.loaded?.content ?? ''),
      );
}
