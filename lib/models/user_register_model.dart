class User {
  final String userName;
  final String email;
  final String consumerId;
  final String productId;
  final String password;
  final String id;

  User(
      {required this.userName,
      required this.email,
      required this.consumerId,
      required this.productId,
      required this.password,
      required this.id});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'],
      email: json['email'],
      consumerId: json['consumerId'],
      productId: json['productId'],
      password: json['password'],
      id: json['_id'],
    );
  }
}