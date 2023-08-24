import 'dart:async';

import 'package:flutter/widgets.dart';

class StreamConsumer<T> extends StatefulWidget {
  const StreamConsumer({
    required this.stream,
    required this.builder,
    this.listener,
    super.key,
  });

  final Stream<T> stream;
  final Widget Function(BuildContext context, T? state) builder;
  final Function(T state)? listener;

  @override
  State<StreamConsumer<T>> createState() => _StreamConsumerState<T>();
}

class _StreamConsumerState<T> extends State<StreamConsumer<T>> {
  late final StreamSubscription subscription;

  T? state;

  @override
  void initState() {
    subscription = widget.stream.listen((event) {
      widget.listener?.call(event);

      setState(() {
        state = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context, state);

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }
}
