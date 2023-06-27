import 'package:trip_brain_ui/src/core/cubit_plus.dart';
import 'package:trip_brain_ui/src/features/suggestions/suggestions_page_state.dart';

import 'package:trip_brain_domain/trip_brain_domain.dart';

class SuggestionsPageCubit extends CubitPlus<SuggestionsPageState> {
  SuggestionsPageCubit({required this.suggester})
      : super(SuggestionsPageState());

  final PlaceSuggester suggester;

  void onSuggestRequest(PlaceSuggestionQueryModel query) {
    emit(state.copyWith(isLoading: true, error: ''));

    addSubscription(
      suggester.suggestPlaces(query).listen(
        (places) =>
            emit(state.copyWith(suggestionPlaces: places, isLoading: false)),
        onError: (Object error) {
          emit(state.copyWith(error: error.toString(), isLoading: false));
        },
      ),
    );
  }
}
