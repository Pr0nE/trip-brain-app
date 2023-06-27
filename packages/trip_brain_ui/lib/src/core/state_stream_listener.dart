import 'dart:async';

import 'package:flutter/widgets.dart';

class StateStreamListener<T> extends StatefulWidget {
  const StateStreamListener({
    required this.stream,
    required this.child,
    required this.onState,
    super.key,
  });

  final Stream<T> stream;
  final Widget child;
  final Function(T state) onState;

  @override
  State<StateStreamListener<T>> createState() => _StateStreamListenerState<T>();
}

class _StateStreamListenerState<T> extends State<StateStreamListener<T>> {
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
