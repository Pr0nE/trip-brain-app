import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class CubitPlus<S> extends Cubit<S> {
  CubitPlus(super.initialState);

  final List<StreamSubscription> subscriptions = [];

  addSubscription(StreamSubscription subscription) =>
      subscriptions.add(subscription);

  @override
  Future<void> close() async {
    for (final StreamSubscription subscription in subscriptions) {
      await subscription.cancel();
    }
    return super.close();
  }
}
