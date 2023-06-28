import 'package:flutter/material.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({required this.onSuggestPlacesTapped, super.key});

  final void Function({required String basePlace}) onSuggestPlacesTapped;

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  late final TextEditingController _travelPlaceTextFieldController;

  String get travelPlace => _travelPlaceTextFieldController.text;

  @override
  void initState() {
    super.initState();

    _travelPlaceTextFieldController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 38,
                ),
                Text(
                  'I want travel to ',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                TextField(
                  controller: _travelPlaceTextFieldController,
                  style: Theme.of(context).textTheme.headlineMedium,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Beach places',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.white38)),
                ),
                TextButton.icon(
                  onPressed: () =>
                      widget.onSuggestPlacesTapped(basePlace: travelPlace),
                  icon: const Icon(Icons.search),
                  label: const Text('Suggest'),
                ),
              ],
            ),
          ),
        ),
      );
}
