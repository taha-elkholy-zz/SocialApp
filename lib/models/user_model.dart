class UserModel {
  late String userId;
  late String name;
  late String email;
  late String phone;
  late String? image;
  late bool isEmailVerified;

// create constructor
  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    // isEmailVerified start with false always
    this.isEmailVerified = false,
    this.image,
  });

  // convert the map to model
  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    isEmailVerified = json['is_email_verified'];
    image = json['image'];
  }

  // convert data to map
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'is_email_verified': isEmailVerified,
      'image': image,
    };
  }
}
