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


// class SuggestionsPageState {
//   SuggestionsPageState({
//     this.isLoading = false,
//     this.error,
//     List<Place>? suggestionPlaces,
//   }) {
//     this.suggestionPlaces.addAll(suggestionPlaces ?? []);
//   }

//   final bool isLoading;
//   final AppException? error;
//   final List<Place> suggestionPlaces = [];

//   SuggestionsPageState copyWith({
//     bool? isLoading,
//     AppException? error,
//     List<Place>? suggestionPlaces,
//   }) =>
//       SuggestionsPageState(
//         isLoading: isLoading ?? this.isLoading,
//         error: error ?? this.error,
//         suggestionPlaces: suggestionPlaces ?? this.suggestionPlaces,
//       );
// }

// extension Status on SuggestionsPageState {
//   bool get isIdle => !isLoading && suggestionPlaces.isEmpty && error == null;
//   bool get hasError => error != null;
//   bool get isSuggestionsFinished =>
//       suggestionPlaces.isNotEmpty && !hasError && !isLoading;
// }
