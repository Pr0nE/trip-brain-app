class User {
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
    return User(id: '', name: 'Guest', token: 'guest');
  }

  final String id;
  final String name;
  final String token;
  final int balance;
}
