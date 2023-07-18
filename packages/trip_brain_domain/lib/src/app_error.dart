enum AppErrorType {
  expiredToken,
  network, // when we find out network is off after calling an api
  needNetwork, // when we know network is off before calling an api that won't work without network
  unknown,
}

class AppException implements Exception {
  AppException(this.type, {this.message});

  final AppErrorType type;

  final String? message;

  @override
  String toString() {
    if (message != null) {
      return message!;
    }

    switch (type) {
      case AppErrorType.expiredToken:
        return 'Your token is expired';
      case AppErrorType.network:
        return 'You have internet connection problems';
      case AppErrorType.needNetwork:
        return 'You need internet connection to continue';
      case AppErrorType.unknown:
        return 'An unknown error happened';
    }
  }
}
