import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:trip_brain_domain/trip_brain_domain.dart';

import 'package:trip_brain_ui/src/features/suggestions/place_tile.dart';
import 'package:trip_brain_ui/src/features/suggestions/suggestions_page_cubit.dart';
import 'package:trip_brain_ui/src/features/suggestions/suggestions_page_state.dart';

class SuggestionsLayout extends StatelessWidget {
  const SuggestionsLayout({
    required this.queryModel,
    required this.placeSuggester,
    required this.imageFetcher,
    required this.onChangeSuggestionQuery,
    required this.onPlaceTapped,
    required this.onError,
    super.key,
  });

  final PlaceSuggestionQueryModel queryModel;
  final PlaceSuggester placeSuggester;
  final PlaceImageFetcher imageFetcher;
  final void Function({required PlaceSuggestionQueryModel queryModel})
      onChangeSuggestionQuery;
  final void Function(Place place) onPlaceTapped;
  final void Function(AppException error, VoidCallback retryCallback) onError;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: BlocProvider<SuggestionsPageCubit>(
            create: (context) => SuggestionsPageCubit(suggester: placeSuggester)
              ..onSuggestRequest(queryModel),
            child: BlocListener<SuggestionsPageCubit, SuggestionsPageState>(
              listener: (context, state) {
                if (state.hasError) {
                  onError(state.error!, () {} // TODO change after change state
                      );
                }
              },
              child: Builder(
                builder: (context) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('I want travel to ${queryModel.basePlace}'),
                              Text('I Like ${queryModel.likes.join(',')}'),
                              Text(
                                  'I Dislike ${queryModel.dislikes.join(',')}'),
                            ],
                          ),
                          TextButton.icon(
                            onPressed: () => onChangeSuggestionQuery(
                              queryModel: queryModel.copyWith(),
                            ),
                            icon: Icon(Icons.settings),
                            label: Text('Change'),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: BlocBuilder<SuggestionsPageCubit,
                          SuggestionsPageState>(
                        builder: (context, state) {
                          print(
                              state.suggestionPlaces.firstOrNull?.description);
                          return state.isLoading
                              ? const SizedBox.expand(
                                  child: Center(
                                      child: CircularProgressIndicator()),
                                )
                              : ListView.separated(
                                  itemCount: state.suggestionPlaces.length,
                                  itemBuilder: (context, index) => PlaceTile(
                                    key: ValueKey(
                                      state.suggestionPlaces[index].title,
                                    ),
                                    place:
                                        state.suggestionPlaces[index].copyWith(
                                      basePlace: queryModel.basePlace,
                                    ),
                                    imageFetcher: imageFetcher,
                                    onPlaceTapped: onPlaceTapped,
                                  ),
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(height: 48),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
}
