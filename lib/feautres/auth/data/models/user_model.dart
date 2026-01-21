import 'package:mauri_pay/feautres/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String role;
  UserModel({
    required super.userId,
    required super.nni,
    required super.firstName,
    required super.lastName,
    required super.phone,
    required super.password,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["user_id"] ?? 0,
      nni: json["nni"] ?? "",
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      phone: json["phone"] ?? "",
      role: json["role"],
      password: "",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "user_id": userId,
      "nni": nni,
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phone,
      "role": role,
    };
  }
}
