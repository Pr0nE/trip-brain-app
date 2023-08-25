import 'package:trip_brain_domain/trip_brain_domain.dart';

abstract class SuggestionsPageState {
  List<Place> get getSuggestionPlaces =>
      asOrNull<SuggestionsPageLoadedState>()?.suggestionPlaces ?? [];
}

class SuggestionsPageInitState extends SuggestionsPageState {}

class SuggestionsPageLoadingState extends SuggestionsPageState {}

class SuggestionsPageErrorState extends SuggestionsPageState {
  SuggestionsPageErrorState(this.error, this.retryCallback);

  final AppException error;
  final void Function() retryCallback;
}

class SuggestionsPageLoadedState extends SuggestionsPageState {
  SuggestionsPageLoadedState(this.suggestionPlaces);

  final List<Place> suggestionPlaces;
}
