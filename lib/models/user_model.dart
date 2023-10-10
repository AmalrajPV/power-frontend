class UserProfile {
  final String userName;
  final String email;
  final String consumerId;
  final String productId;
  final String id;

  UserProfile(
      {required this.userName,
      required this.email,
      required this.consumerId,
      required this.productId,
      required this.id});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'],
      userName: json['userName'],
      email: json['email'],
      consumerId: json['consumerId'],
      productId: json['productId'],
    );
  }
}
