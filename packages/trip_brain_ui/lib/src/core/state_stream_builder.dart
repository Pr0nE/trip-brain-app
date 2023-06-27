import 'dart:async';

import 'package:flutter/widgets.dart';

class StateStreamBuilder<T> extends StatefulWidget {
  const StateStreamBuilder({
    required this.stream,
    required this.onStateBuilder,
    this.onState,
    super.key,
  });

  final Stream<T> stream;
  final Widget Function(BuildContext context, T? state) onStateBuilder;
  final Function(T state)? onState;

  @override
  State<StateStreamBuilder<T>> createState() => _StateStreamBuilderState<T>();
}

class _StateStreamBuilderState<T> extends State<StateStreamBuilder<T>> {
  late final StreamSubscription subscription;

  T? state;

  @override
  void initState() {
    subscription = widget.stream.listen((event) {
      widget.onState?.call(event);

      setState(() {
        state = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => widget.onStateBuilder(context, state);

  @override
  void dispose() {
    subscription.cancel();

    super.dispose();
  }
}
