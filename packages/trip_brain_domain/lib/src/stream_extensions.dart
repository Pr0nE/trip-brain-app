extension StreamExtension<T> on Stream<T> {
  Stream<K> whereType<K>() =>
      where((event) => event is K).map((event) => (event as K));
}
