import 'package:flutter/material.dart';
import 'package:trip_brain_domain/trip_brain_domain.dart';

class SuggestionPricesBottomSheet extends StatefulWidget {
  const SuggestionPricesBottomSheet({
    required this.paymentManager,
    required this.onSuccess,
    required this.onSuggestionPriceTapped,
    required this.onError,
    super.key,
  });

  final PaymentManager paymentManager;
  final VoidCallback onSuccess;
  final void Function(int selectedAmount) onSuggestionPriceTapped;
  final void Function(AppException error, {VoidCallback? retryCallback})
      onError;

  @override
  State<SuggestionPricesBottomSheet> createState() =>
      _SuggestionPricesBottomSheetState();
}

class _SuggestionPricesBottomSheetState
    extends State<SuggestionPricesBottomSheet> with TickerProviderStateMixin {
  bool isLoading = false;

  late Future<List<SuggestionPrice>> suggestionPricesFuture;
  late final AnimationController animationController;

  @override
  void initState() {
    _fetchPrices();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) => BottomSheet(
        animationController: animationController,
        builder: (context) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              IgnorePointer(
                ignoring: isLoading,
                child: Opacity(
                  opacity: isLoading ? 0.1 : 1,
                  child: FutureBuilder<List<SuggestionPrice>>(
                      future: suggestionPricesFuture,
                      builder: (context, snap) {
                        final prices = snap.data ?? [];

                        return AnimatedSize(
                          duration: const Duration(milliseconds: 150),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: prices
                                .map(
                                  (price) => TextButton(
                                    onPressed: () =>
                                        onAmountSelected(context, price.amount),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text('${price.amount} Suggestions'),
                                        Text('${price.price.toInt()} \$'),
                                      ],
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        );
                      }),
                ),
              ),
              if (isLoading) const CircularProgressIndicator()
            ],
          ),
        ),
        onClosing: () {},
      );

  void onAmountSelected(BuildContext context, int selectedAmount) {
    widget.onSuggestionPriceTapped(selectedAmount);

    widget.paymentManager.buyBalance(selectedAmount).on(
          onLoading: () => setState(() => isLoading = true),
          onError: (AppException error) {
            widget.onError(
              error,
              retryCallback: () => onAmountSelected(context, selectedAmount),
            );
            setState(() => isLoading = false);
          },
          onData: (result) {
            // TODO: show success message
            widget.onSuccess();
            setState(() => isLoading = false);
          },
        );
  }

  void _fetchPrices() {
    suggestionPricesFuture =
        widget.paymentManager.getSuggestionPrices().catchError((error) {
      widget.onError(error, retryCallback: _fetchPrices);
      return <SuggestionPrice>[];
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
