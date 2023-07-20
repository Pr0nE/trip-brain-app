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
          return ListView.separated(
            itemBuilder: (context, index) => ListTile(
              title: Text(snapshot.data?[index].basePlace ?? ''),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Likes: ${snapshot.data?[index].likes.join(',') ?? ''}'),
                  Text(
                      'Dislikes: ${snapshot.data?[index].dislikes.join(',') ?? ''}'),
                ],
              ),
              onTap: () => onRecentSearchTapped(snapshot.data![index]),
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemCount: snapshot.data?.length ?? 0,
          );
        },
      );
}
