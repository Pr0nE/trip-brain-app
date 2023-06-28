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
    super.key,
  });

  final PlaceSuggestionQueryModel queryModel;
  final PlaceSuggester placeSuggester;
  final PlaceImageFetcher imageFetcher;
  final void Function({required PlaceSuggestionQueryModel queryModel})
      onChangeSuggestionQuery;

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: BlocProvider<SuggestionsPageCubit>(
            create: (context) => SuggestionsPageCubit(suggester: placeSuggester)
              ..onSuggestRequest(queryModel),
            child: BlocListener<SuggestionsPageCubit, SuggestionsPageState>(
              listener: (context, state) {
                if (state.hasError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
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
                        builder: (context, state) => state.isLoading
                            ? const SizedBox.expand(
                                child:
                                    Center(child: CircularProgressIndicator()),
                              )
                            : ListView.separated(
                                itemCount: state.suggestionPlaces.length,
                                itemBuilder: (context, index) => PlaceTile(
                                  key: ValueKey(
                                      state.suggestionPlaces[index].title),
                                  title: state.suggestionPlaces[index].title,
                                  description:
                                      state.suggestionPlaces[index].description,
                                  imageFetcher: imageFetcher,
                                  basePlace: queryModel.basePlace,
                                ),
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 48),
                              ),
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
