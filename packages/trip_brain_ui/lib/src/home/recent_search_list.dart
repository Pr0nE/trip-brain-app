import 'package:flutter/material.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

class RecentSearchList extends StatelessWidget {
  const RecentSearchList({
    required this.fetcher,
    required this.onRecentSearchTapped,
    super.key,
  });

  final RecentSuggestionsFetcher fetcher;
  final void Function(PlaceSuggestionQuery query) onRecentSearchTapped;

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: fetcher.fetchRecentSuggestions(),
        builder: (context, snapshot) {
          final searchList = snapshot.data ?? [];

          if (searchList.isEmpty) {
            //TODO return a new user guid, app feature showcase
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Suggestions',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Expanded(child: _buildRecentList(searchList))
            ],
          );
        },
      );

  Widget _buildRecentList(List<PlaceSuggestionQuery> searches) =>
      ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) => Card(
          child: ListTile(
            tileColor: Theme.of(context).colorScheme.primary.withOpacity(0.4),
            title: Text(
              searches[index].basePlace,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  searches[index].likes.isNotEmpty
                      ? 'likes: ${searches[index].likes.join(', ')}'
                      : 'no likes',
                ),
                Text(
                  searches[index].dislikes.isNotEmpty
                      ? 'dislikes: ${searches[index].dislikes.join(', ')}'
                      : 'no dislikes',
                )
              ],
            ),
            onTap: () => onRecentSearchTapped(searches[index]),
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemCount: searches.length,
      );
}
