import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/core/cubit_plus.dart';

abstract class PlaceDetailViewerState {
  PlaceDetailViewerLoadedState? get loaded =>
      asOrNull<PlaceDetailViewerLoadedState>();
}

class PlaceDetailViewerInitialState extends PlaceDetailViewerState {}

class PlaceDetailViewerLoadingState extends PlaceDetailViewerState {}

class PlaceDetailViewerErrorState extends PlaceDetailViewerState {
  PlaceDetailViewerErrorState(this.error, this.retryCallback);

  final AppException error;
  final void Function() retryCallback;
}

class PlaceDetailViewerLoadedState extends PlaceDetailViewerState {
  PlaceDetailViewerLoadedState(this.content);

  final String content;
}

class PlaceDetailViewerCubit extends CubitPlus<PlaceDetailViewerState> {
  PlaceDetailViewerCubit({required this.fetcher})
      : super(PlaceDetailViewerInitialState());

  final PlaceDetailFetcher fetcher;

  void fetchDetails(String place, PlaceDetail detail) {
    emit(PlaceDetailViewerLoadingState());

    addSubscription(
      fetcher.fetchDetail(place: place, detail: detail).listen(
        (details) => emit(PlaceDetailViewerLoadedState(details)),
        onError: (Object error) {
          if (error is AppException) {
            emit(
              PlaceDetailViewerErrorState(
                error,
                () => fetchDetails(place, detail),
              ),
            );
          }
        },
      ),
    );
  }
}
