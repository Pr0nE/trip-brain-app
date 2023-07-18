import 'package:trip_brain_domain/trip_brain_domain.dart';

// TODO: change to abstract form
class SuggestionsPageState {
  SuggestionsPageState({
    this.isLoading = false,
    this.error,
    List<Place>? suggestionPlaces,
  }) {
    this.suggestionPlaces.addAll(suggestionPlaces ?? []);
  }

  final bool isLoading;
  final AppException? error;
  final List<Place> suggestionPlaces = [];

  SuggestionsPageState copyWith({
    bool? isLoading,
    AppException? error,
    List<Place>? suggestionPlaces,
  }) =>
      SuggestionsPageState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        suggestionPlaces: suggestionPlaces ?? this.suggestionPlaces,
      );
}

extension Status on SuggestionsPageState {
  bool get isIdle => !isLoading && suggestionPlaces.isEmpty && error == null;
  bool get hasError => error != null;
  bool get isSuggestionsFinished =>
      suggestionPlaces.isNotEmpty && !hasError && !isLoading;
}
