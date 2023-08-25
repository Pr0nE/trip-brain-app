class User {
  static const _guestToken = 'guest';

  User({
    required this.id,
    required this.name,
    required this.token,
    this.balance = 0,
  });

  factory User.empty() {
    return User(id: '', name: '', token: '');
  }
  factory User.guest() {
    return User(id: '', name: '', token: _guestToken);
  }

  bool get isGuest => token == _guestToken;

  final String id;
  final String name;
  final String token;
  final int balance;
}
