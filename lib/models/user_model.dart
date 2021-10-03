class UserModel {
  late String userId;
  late String name;
  late String email;
  late String phone;
  late String image;
  late String coverImage;
  late String bio;
  late bool isEmailVerified;

// create constructor
  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    // isEmailVerified start with false always
    this.isEmailVerified = false,
    //default bio text
    this.bio = 'Write your bio here...',
    //default images
    this.image =
        'https://image.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg',
    this.coverImage =
        'https://image.freepik.com/free-photo/portrait-positive-male-with-brunette-hair-bristle-has-piercing-wearing-black-sweater-holding-mobile-phone-copy-space-right-isolated-yellow-wall_295783-14551.jpg',
  });

  // convert the map to model
  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    isEmailVerified = json['is_email_verified'];
    image = json['image'];
    coverImage = json['cover_image'];
    bio = json['bio'];
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
      'cover_image': coverImage,
      'bio': bio,
    };
  }
}
