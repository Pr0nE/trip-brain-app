class User {
  User({
    required this.id,
    required this.name,
    required this.token,
    this.balance = 0,
  });

  final String id;
  final String name;
  final String token;
  final int balance;
}
