extension FutureExtensions<T> on Future<T> {
  void on<ERROR>({
    void Function(T)? onData,
    void Function()? onLoading,
    void Function(ERROR)? onError,
  }) {
    onLoading?.call();

    then(
      (data) => onData?.call(data),
    ).catchError(
      (Object error) {
        if (error is ERROR) {
          onError?.call(error as ERROR);
        }
      },
    );
  }
}
