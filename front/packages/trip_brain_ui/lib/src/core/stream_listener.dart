import 'dart:async';

import 'package:flutter/widgets.dart';

class StreamListener<T> extends StatefulWidget {
  const StreamListener({
    required this.stream,
    required this.child,
    required this.onState,
    super.key,
  });

  final Stream<T> stream;
  final Widget child;
  final Function(T state) onState;

  @override
  State<StreamListener<T>> createState() => _StreamListenerState<T>();
}

class _StreamListenerState<T> extends State<StreamListener<T>> {
  late final StreamSubscription subscription;

  T? state;

  @override
  void initState() {
    subscription = widget.stream.listen((event) => widget.onState.call(event));

    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.child;

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }
}
