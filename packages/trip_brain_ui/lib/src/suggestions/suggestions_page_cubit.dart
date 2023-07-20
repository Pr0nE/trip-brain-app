import 'package:trip_brain_ui/src/core/cubit_plus.dart';

import 'package:trip_brain_domain/trip_brain_domain.dart';
import 'package:trip_brain_ui/src/suggestions/suggestions_page_state.dart';

class SuggestionsPageCubit extends CubitPlus<SuggestionsPageState> {
  SuggestionsPageCubit({required this.suggester})
      : super(SuggestionsPageInitState());

  final PlaceSuggester suggester;

  void onSuggestRequest(PlaceSuggestionQuery query) {
    emit(SuggestionsPageLoadingState());

    try {
      addSubscription(
        suggester.suggestPlaces(query).listen(
          (places) => emit(SuggestionsPageLoadedState(places)),
          onError: (Object error) {
            if (error is AppException) {
              emit(
                SuggestionsPageErrorState(error, () => onSuggestRequest(query)),
              );
            }
          },
        ),
      );
    } on AppException catch (error) {
      emit(SuggestionsPageErrorState(error, () => onSuggestRequest(query)));
    }
  }
}
