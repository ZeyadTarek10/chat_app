import 'package:chat_app/features/sign_up/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.name,
    required super.email,
    required super.phone,
    required super.countryCode,
    required super.gender,
    required super.birthday,
    super.profilePicUrl
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      countryCode: json['country_code'] ?? '+20',
      gender: json['gender'] ?? '',
      birthday: json['birthday'] ?? '',
      profilePicUrl: json['profile_pic_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'country_code': countryCode,
      'gender': gender,
      'birthday': birthday,
      'profile_pic_url': profilePicUrl,
    };
  }
}
