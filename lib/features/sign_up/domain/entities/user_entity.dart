class UserEntity {
  final String uid;
  final String name;
  final String email;
  final String phone;
  final String countryCode;
  final String gender;      
  final String birthday;    
  final String? profilePicUrl;

  UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.countryCode,
    required this.gender,
    required this.birthday,
    this.profilePicUrl,
  });
}
