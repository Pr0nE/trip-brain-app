import 'package:flutter/material.dart';

class CustomFutureBuilder<T> extends StatelessWidget {
  const CustomFutureBuilder({
    required this.future,
    required this.onSuccess,
    required this.onLoading,
    this.onError,
    this.onErrorBuilder,
    super.key,
  });

  final Future<T> future;
  final Widget Function(BuildContext context, T data) onSuccess;
  final Widget Function(BuildContext context) onLoading;
  final Widget Function(BuildContext context, Object error)? onErrorBuilder;
  final void Function(Object error)? onError;

  @override
  Widget build(BuildContext context) => FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return onSuccess(context, snapshot.data as T);
          }

          if (snapshot.hasError) {
            onError?.call(snapshot.error!);

            return onErrorBuilder != null
                ? onErrorBuilder!(context, snapshot.error!)
                : onLoading(context);
          }

          return onLoading(context);
        },
      );
}
